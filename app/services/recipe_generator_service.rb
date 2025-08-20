require "open-uri" # Necessário para fazer download da imagem gerada

class RecipeGeneratorService
  def initialize(recipe, locale)
    @recipe = recipe # Armazena a receita fornecida
    @ingredients = recipe.ingredients # Extrai os ingredientes da receita
    @client = OpenAI::Client.new # Inicializa o cliente OpenAI com a configuração definida no initializer
    @locale = locale # Armazena o idioma atual
  end

  def call # Método principal que gera a receita
    text_prompt = create_text_prompt # Cria o prompt de texto para a geração da receita
    recipe_response = @client.chat( # Envia a solicitação para a API OpenAI
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [ { role: "user", content: text_prompt } ],
        temperature: 0.7
      }
    )
    generated_text = recipe_response.dig("choices", 0, "message", "content") # Extrai o texto gerado da resposta
    recipe_data = parse_generated_text(generated_text) # Analisa o texto gerado e extrai os dados da receita

    # Atualiza os atributos da receita com os dados gerados
    @recipe.title = recipe_data[:title]
    @recipe.instructions = recipe_data[:instructions]

    image_prompt = "#{I18n.t('.image_prompt_prefix')} #{@recipe.title}" # Cria o prompt de imagem para a geração da foto
    image_response = @client.images.generate(
      parameters: {
        model: "dall-e-3",
        prompt: image_prompt,
        n: 1,
        size: "1792x1024"
      }
    )

    # --- LINHA DE DEBUG ---
    puts "RESPOSTA DA API DE IMAGEM: #{image_response.inspect}"
    # ---------------------------

    temp_image_url = image_response.dig("data", 0, "url") # Extrai a URL da imagem gerada

    if temp_image_url.present? # Verifica se a URL da imagem está presente
      image_file = URI.open(temp_image_url) # Abre a URL da imagem
      @recipe.photo.attach(io: image_file, filename: "#{@recipe.title.parameterize}.png") # Anexa a imagem à receita
    end
    true # Indica que a geração da receita foi bem-sucedida
  end

  private

  def create_text_prompt # Método para criar o prompt de texto para a geração da receita
    <<~PROMPT
      Você é um chef de cozinha especializado em criar receitas deliciosas, saudáveis, criativas e fáceis de preparar. Sua tarefa é gerar uma receita deliciosa e fácil de seguir usando apenas os ingredientes fornecidos.

      Siga estritamente as seguintes regras:
      1. A resposta DEVE ser apenas o texto da receita, sem nenhuma introdução ou comentário seu.
      2. O formato da resposta DEVE ser exatamente:
      TÍTULO: [aqui o título criativo da receita]
      INSTRUÇÕES: [aqui o passo a passo do modo de preparo da receita, com cada passo numerado]
      3. Gere a receita inteira (título e instruções) no seguinte idioma: #{@locale}.

      Ingredientes fornecidos: #{@ingredients}
    PROMPT
  end

  def parse_generated_text(generated_text) # Método para analisar o texto gerado e extrair o título e as instruções
    return { title: "Erro: Formato de resposta inválido", instructions: generated_text } unless generated_text&.include?("TÍTULO:") && generated_text&.include?("INSTRUÇÕES:") # Verifica se o texto contém as seções esperadas

    title = generated_text.match(/TÍTULO:(.*?)INSTRUÇÕES:/m)[1].strip # Extrai o título da receita
    instructions = generated_text.match(/INSTRUÇÕES:(.*)/m)[1].strip # Extrai as instruções da receita

    { title: title, instructions: instructions } # Retorna um hash com o título e as instruções
  end
end
