require 'rails_helper'

RSpec.describe Recipe, type: :model do
  context "validações" do
    it "é válida com atributos válidos" do
      # Factory para garantir que uma receita normal é válida
      recipe = build(:recipe)
      expect(recipe).to be_valid
    end

    it "não é válida sem um título" do
      recipe = build(:recipe, title: nil)
      expect(recipe).not_to be_valid
    end

    it "não é válida sem ingredientes" do
      recipe = build(:recipe, ingredients: nil)
      expect(recipe).not_to be_valid
    end

    it "não é válida sem instruções" do
      recipe = build(:recipe, instructions: nil)
      expect(recipe).not_to be_valid
    end

    it "não é válida sem um usuário associado" do
      recipe = build(:recipe, user: nil)
      expect(recipe).not_to be_valid
    end
  end
end
