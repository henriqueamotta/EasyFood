class Recipe < ApplicationRecord
  belongs_to :user
  has_one_attached :photo
  has_many :recipe_translations, dependent: :destroy

  def translation_for(locale) # Método que busca a tradução para um determinado idioma
    # Procura por uma tradução que já exista no banco de dados
    translation = recipe_translations.find_by(locale: locale.to_s)
    translation if translation.present?

    # Se não houver tradução, gera uma nova
    translated_data = RecipeTranslatorService.new(self, locale).call

    # Se a tradução falhar (serviço retornou nil), não faz nada
    return nil unless translated_data

    # Salva a nova tradução no banco de dados para uso futuro
    recipe_translations.create(
      locale: locale.to_s,
      title: translated_data[:title],
      instructions: translated_data[:instructions]
    )
  end
end
