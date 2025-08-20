require 'rails_helper'

RSpec.describe "Recipes", type: :request do
  # Cria um usuário e uma receita no banco de dados de teste ANTES de cada teste
  let!(:user) { create(:user) }
  let!(:recipe) { create(:recipe, user: user) }

  # --- Testes para a página PÚBLICA de uma receita ---
  describe "GET /recipes/:id" do
    it "retorna uma resposta de sucesso" do
      # Faz uma requisição GET para a página da receita
      get recipe_path(recipe)

      # Expectativa: a resposta HTTP deve ser 200 OK (sucesso)
      expect(response).to have_http_status(:success)
    end

    it "renderiza o template 'show'" do
      get recipe_path(recipe)

      # Expectativa: a página renderizada deve ser a 'show.html.erb'
      expect(response).to render_template(:show)
    end
  end

  # --- Testes para a página RESTRITA de nova receita ---
  describe "GET /recipes/new" do
    context "quando o usuário NÃO está logado" do
      it "redireciona para a página de login" do
        # Faz a requisição sem logar
        get new_recipe_path

        # Expectativa: a resposta deve ser um redirecionamento (status 302) para a página de login.
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "quando o usuário ESTÁ logado" do
      it "retorna uma resposta de sucesso" do
        # O helper do Devise para simular o login
        sign_in user

        # Faz a requisição logado
        get new_recipe_path

        # Expectativa: a resposta deve ser de sucesso (status 200)
        expect(response).to have_http_status(:success)
      end
    end
  end
  describe "POST /recipes" do
    context "com parâmetros válidos" do
      before do
        sign_in user # Loga o usuário antes dos testes deste contexto
      end

      it "cria uma nova receita" do
        # Pega os atributos da nossa factory de receita
        valid_params = attributes_for(:recipe)

        # Expectativa: que o código dentro do bloco {} mude a contagem de Recipe no banco de dados em +1.
        expect {
          post recipes_path, params: { recipe: valid_params }
        }.to change(Recipe, :count).by(1)
      end

      it "redireciona para a página da receita criada" do
        valid_params = attributes_for(:recipe)
        post recipes_path, params: { recipe: valid_params }

        # Expectativa: a resposta deve ser um redirecionamento para a página da última receita criada.
        expect(response).to redirect_to(Recipe.last)
      end
    end

    context "com parâmetros inválidos" do
      before do
        sign_in user
      end

      it "não cria uma nova receita" do
        # Parâmetros inválidos (título em branco)
        invalid_params = attributes_for(:recipe, title: nil)

        # Expectativa: o código NÃO deve mudar a contagem de Recipe.
        expect {
          post recipes_path, params: { recipe: invalid_params }
        }.not_to change(Recipe, :count)
      end

      it "renderiza a página 'new' novamente com status unprocessable_content" do
        invalid_params = attributes_for(:recipe, title: nil)
        post recipes_path, params: { recipe: invalid_params }

        # Expectativa: a resposta deve ser 422 e renderizar o template 'new'
        expect(response).to have_http_status(:unprocessable_content)
        expect(response).to render_template(:new)
      end
    end
  end
end
