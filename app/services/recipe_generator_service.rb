class RecipeGeneratorService
  def initialize(ingredients) # Inicializa o serviço com os ingredientes fornecidos
    @ingredients = ingredients # Armazena os ingredientes fornecidos
    @client = OpenAI::Client.new # Cria uma nova instância do cliente OpenAI
  end

  def call # Gera uma receita com os ingredientes fornecidos
    prompt = <<~PROMPT
      Você é um chef de cozinha especializado em criar receitas deliciosas, saudáveis, criativas e fáceis de preparar. Sua tarefa é gerar uma receita deliciosa e fácil de seguir usando apenas os ingredientes fornecidos.

      Siga estritamente as seguintes regras:
      1. A resposta deve ser na língua que o usuário está falando.
      2. A resposta DEVE ser apenas o texto da receita, sem nenhuma introdução ou comentário seu.
      3. O formato da resposta DEVE ser exatamente:

      TÍTULO: [aqui o título criativo da receita]
      INSTRUÇÕES: [aqui o passo a passo do modo de preparo da receita, com cada passo numerado]

      Ingredientes fornecidos: #{@ingredients.join(', ')}.

      Gere uma receita deliciosa e fácil de seguir usando esses ingredientes. Você pode adicionar ingredientes adicionais, mas deve garantir que a receita seja fácil de seguir e deliciosa.
    PROMPT

    response = @client.chat( # Envia a solicitação para o modelo de linguagem
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt }],
        temperature: 0.7
      }
    )

    generated_text = response.dig("choices", 0, "message", "content") # Obtém o texto gerado pela IA

    parse_generated_text(generated_text) # Analisa o texto gerado para extrair título e instruções
  end

  private

  def parse_generated_text(generated_text) # Analisa o texto gerado para extrair título e instruções
    { title: "Erro ao gerar receita", instructions: text } unless text.include?("TÍTULO:") && text.include?("INSTRUÇÕES:") # Verifica se o texto contém as seções esperadas

    title = text.match(/TÍTULO:\s*(.*)/)[1].strip # Extrai o título da receita
    instructions = text.match(/INSTRUÇÕES:\s*(.*)/m)[1].strip # Extrai as instruções da receita

    { title: title, instructions: instructions } # Retorna um hash com o título e as instruções da receita
  end
end
