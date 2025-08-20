class AddIngredientsToRecipeTranslations < ActiveRecord::Migration[8.0]
  def change
    add_column :recipe_translations, :ingredients, :text
  end
end
