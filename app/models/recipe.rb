class Recipe < ApplicationRecord
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients

  # validates :name, presence: true, uniqueness: true
  validates :ingredients, presence: true
  validates :instructions, presence: true

  after_create :set_instructions, if: -> { instructions.blank? }

  after_save :set_instructions, if: -> { saved_change_to_ingredient_ids? && instructions.blank? }

  def instructions
    if super.blank?
      set_instructions
    else
      super
    end
  end

  private

  def set_instructions # rubocop:disable Metrics/MethodLength
    # Debug: Verifique os ingredientes
    Rails.logger.debug "Ingredientes: #{ingredients.pluck(:name).join(', ')}"

    user = OpenAI::Client.new
    response = user.chat(parameters: {
                           model: "gpt-4",
                           messages: [{
                             role: "user",
                             content: "Sugira uma receita simples usando somente os seguintes ingredientes: #{ingredients.pluck(:name).join(', ')}. Retorne apenas o texto da receita, sem introduções ou respostas adicionais como 'Aqui está uma receita simples'." # rubocop:disable Layout/LineLength
                           }]
                         })

    # Resposta da API
    new_instructions = response["choices"][0]["message"]["content"]

    # Atualizar o atributo 'instructions' no banco de dados
    update!(instructions: new_instructions)
    return new_instructions
  end
end
