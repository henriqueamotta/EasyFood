class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  validates :name, presence: true, uniqueness: true
  validates :instructions, presence: true

  after_save :set_instructions, if: -> { saved_change_to_name? || saved_change_to_ingredients? }

  def instructions
    if super.blank?
      set_instructions
    else
      super
    end
  end

  private

  def set_instructions
    client = OpenAI::Client.new
    prompt = "Sugira uma receita simples chamada '#{name}' usando os seguintes ingredientes: #{ingredients.pluck(:name).join(', ')}. Retorne apenas o texto da receita, sem introduções ou respostas adicionais como 'Aqui está uma receita simples'." # rubocop:disable Layout/LineLength

    # Chamada à API da OpenAI
    chatgpt_response = client.chat(parameters: {
                                     model: "gpt-4",
                                     messages: [{ role: "user", content: prompt }]
                                   })

    # Resposta da API
    new_instructions = chatgpt_response["choices"][0]["message"]["content"]

    # Atualizar o atributo 'instructions' no banco de dados
    update(instructions: new_instructions)
    return new_instructions
  end
end
