require 'rails_helper'

RSpec.describe User, type: :model do
  context "validações" do
    it "é válido com atributos válidos" do
      expect(build(:user)).to be_valid
    end

    it "não é válido sem um nome" do
      user = build(:user, name: nil)
      expect(user).not_to be_valid
    end
  end

  context "associações" do
    it "deve ter muitas receitas" do
      # Teste que verifica se a associação has_many :recipes está configurada
      user = User.reflect_on_association(:recipes)
      expect(user.macro).to eq(:has_many)
    end
  end
end
