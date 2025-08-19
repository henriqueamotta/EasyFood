class CreateRecipeTranslations < ActiveRecord::Migration[8.0]
  def change
    create_table :recipe_translations do |t|
      t.references :recipe, null: false, foreign_key: true
      t.string :locale
      t.string :title
      t.text :instructions

      t.timestamps
    end
  end
end
