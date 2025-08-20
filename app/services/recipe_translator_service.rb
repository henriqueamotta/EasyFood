class RecipeTranslatorService
  def initialize(recipe, target_locale)
    @recipe = recipe
    @target_locale = target_locale
    @client = OpenAI::Client.new
  end

  def call # Método principal que gera a tradução da receita
    prompt = create_translation_prompt

    response = @client.chat(
      parameters: {
        model: "gpt-3.5-turbo",
        messages: [{ role: "user", content: prompt }],
        temperature: 0.3 # Temperatura mais baixa para traduções mais literais
      }
    )

    translated_text = response.dig("choices", 0, "message", "content")
    parse_translated_text(translated_text) # Método que analisa o texto traduzido
  end

  private

  def create_translation_prompt
    <<~PROMPT
      Você é um assistente de tradução especializado em receitas culinárias. Sua tarefa é traduzir o título e as instruções de uma receita para o idioma alvo.

      Siga estritamente as seguintes regras:
      1. A resposta DEVE ser apenas a tradução, sem nenhuma introdução ou comentário seu.
      2. Mantenha a formatação original das instruções (numeração, quebras de linha).
      3. O formato da resposta DEVE ser exatamente:

      TÍTULO: [aqui o título traduzido]
      INSTRUÇÕES: [aqui as instruções traduzidas]

      Idioma Alvo para a Tradução: #{@target_locale}

      ---
      Texto Original para Traduzir:

      TÍTULO: #{@recipe.title}
      INSTRUÇÕES: #{@recipe.instructions}
    PROMPT
  end

  def parse_translated_text(text)
    # Retorna nulo se a resposta da IA não vier no formato esperado
    return nil unless text&.include?("TÍTULO:") && text&.include?("INSTRUÇÕES:")

    title = text.match(/TÍTULO:(.*?)INSTRUÇÕES:/m)[1].strip
    instructions = text.match(/INSTRUÇÕES:(.*)/m)[1].strip

    { title: title, instructions: instructions }
  end
end
