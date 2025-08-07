class RecipesController < ApplicationController
  before_action :authenticate_user! # Garante que o usuário esteja logado para todas as ações

  def index
    @recipes = current_user.recipes.order(created_at: :desc) # Exibe as receitas do usuário logado, ordenadas pela data de criação
  end

  def show
    @recipe = current_user.recipes.find(params[:id]) # Encontra a receita específica do usuário logado
  end

  def new
    @recipe = Recipe.new # Cria uma nova instância de receita
  end

  def create
    @recipe = current_user.recipes.new(recipe_params) # Cria uma nova receita associada ao usuário logado

    @recipe.title = "Receita para: #{@recipe.ingredients.truncate(30)}" # Define o título da receita com base nos ingredientes
    @recipe.instructions = "Instruções serão geradas pela IA em breve..." # Placeholder para instruções

    if @recipe.save
      redirect_to @recipe, notice: "Receita criada com sucesso! (IA em breve)" # Redireciona para a receita recém-criada com uma mensagem de sucesso
    else
      render :new, status: :unprocessable_entity # Renderiza o formulário novamente em caso de erro
    end
  end
end

private

def recipe_params
  # Permite apenas os parâmetros necessários para criar ou atualizar uma receita
  params.require(:recipe).permit(:ingredients)
end
