class RecipeGeneratorService
  def initialize(ingredients)
    @ingredients = ingredients # Armazena os ingredientes fornecidos
    @client = OpenAI::Client.new # Inicializa o cliente OpenAI com a configuração definida no initializer
  end

  def call # Método principal que gera a receita
    prompt = <<~PROMPT
      Você é um chef de cozinha especializado em criar receitas deliciosas, saudáveis, criativas e fáceis de preparar. Sua tarefa é gerar uma receita deliciosa e fácil de seguir usando apenas os ingredientes fornecidos.

      Siga estritamente as seguintes regras:
      1. A resposta deve ser na língua que o usuário está falando.
      2. A resposta DEVE ser apenas o texto da receita, sem nenhuma introdução ou comentário seu.
      3. O formato da resposta DEVE ser exatamente:

      TÍTULO: [aqui o título criativo da receita]
      INSTRUÇÕES: [aqui o passo a passo do modo de preparo da receita, com cada passo numerado]

      Ingredientes fornecidos: #{@ingredients}
    PROMPT

    response = @client.chat( # Envia a solicitação para a API OpenAI
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt }],
        temperature: 0.7
      }
    )

    generated_text = response.dig("choices", 0, "message", "content") # Extrai o texto gerado da resposta da API
    parse_generated_text(generated_text) # Analisa o texto gerado e retorna um hash com o título e as instruções

    image_prompt = "Uma foto deliciosa de #{recipe_data[:title]}, com foco nos detalhes apetitosos do prato." # Cria um prompt para gerar uma imagem da receita
    image_response = @client.images.generate( # Envia a solicitação para a API de geração de imagens
      parameters: {
        prompt: image_prompt,
        n: 1,
        size: "256x256"
      }
    )
    image_url = image_response.dig("data", 0, "url") # Extrai a URL da imagem gerada

    recipe_data.merge(image_url: image_url) # Adiciona a URL da imagem ao hash de dados da receita
  end

  private

  def parse_generated_text(generated_text) # Método para analisar o texto gerado e extrair o título e as instruções
    return { title: "Erro: Formato de resposta inválido", instructions: generated_text } unless generated_text&.include?("TÍTULO:") && generated_text&.include?("INSTRUÇÕES:") # Verifica se o texto contém as seções esperadas

    title = generated_text.match(/TÍTULO:(.*?)INSTRUÇÕES:/m)[1].strip # Extrai o título da receita
    instructions = generated_text.match(/INSTRUÇÕES:(.*)/m)[1].strip # Extrai as instruções da receita

    { title: title, instructions: instructions } # Retorna um hash com o título e as instruções
  end
end
