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

    begin # Inicia o bloco de tratamento de exceções

      RecipeGeneratorService.new(@recipe).call # Chama o serviço para gerar a receita

      if @recipe.save
        redirect_to @recipe, notice: t(".success")
      else
        render :new, status: :unprocessable_content
      end

    rescue Exception => e
      # --- Bloco de debug detalhado ---
      puts "--- ERRO DETALHADO DA API ---"
      puts "MENSAGEM: #{e.message}"
      puts "BACKTRACE:"
      puts e.backtrace.join("\n")
      puts "-----------------------------"

      flash[:alert] = t(".error") # Captura qualquer erro e exibe uma mensagem de alerta
      render :new, status: :unprocessable_content # Renderiza o formulário novamente em caso de erro
    end
  end

  private

  def recipe_params
  # Permite apenas os parâmetros necessários para criar ou atualizar uma receita
  params.require(:recipe).permit(:ingredients, :title, :instructions, :image_url) # Permite os parâmetros de receita
  end
end
