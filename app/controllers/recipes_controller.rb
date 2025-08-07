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

      service_response = RecipeGeneratorService.new(@recipe.ingredients).call # Chama o serviço para gerar a receita

      @recipe.title = service_response[:title] # Define o título da receita com base na resposta do serviço
      @recipe.instructions = service_response[:instructions] # Define as instruções da receita com base na resposta do serviço

      if @recipe.save
        redirect_to @recipe, notice: "Sua receita foi gerada com sucesso!" # Redireciona para a receita recém-criada com uma mensagem de sucesso
      else
        render :new, status: :unprocessable_entity # Renderiza o formulário novamente em caso de erro
      end

    rescue StandardError => e # Captura qualquer exceção que ocorra durante o processo
      flash[:alert] = "Houve um erro ao gerar sua receita. Por favor tente novamente. Erro: #{e.message}" # Exibe uma mensagem de erro em caso de exceção
      render :new, status: :unprocessable_entity # Renderiza o formulário novamente em caso de erro
    end
  end

  private

  def recipe_params
  # Permite apenas os parâmetros necessários para criar ou atualizar uma receita
  params.require(:recipe).permit(:ingredients)
  end
end
