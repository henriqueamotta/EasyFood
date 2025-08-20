class RecipesController < ApplicationController
  before_action :authenticate_user!, except: [ :show ] # Permite acesso público à ação "show"

  def index
    @recipes = current_user.recipes.order(created_at: :desc) # Exibe as receitas do usuário logado, ordenadas pela data de criação
  end

  def show
    @recipe = Recipe.find(params[:id]) # Encontra a receita específica

    # Prepara as variáveis para exibição com o conteúdo original por padrão
    @display_title = @recipe.title
    @display_ingredients = @recipe.ingredients
    @display_instructions = @recipe.instructions

    # Verifica se o idioma da interface é diferente do padrão (pt-BR)
    if I18n.locale != I18n.default_locale
      translation = @recipe.translation_for(I18n.locale) # Pede ao modelo para buscar ou criar uma tradução

      # Se a tradução foi encontrada ou criada com sucesso, usa os textos traduzidos
      if translation
        @display_title = translation.title # Exibe o título traduzido
        @display_ingredients = translation.ingredients # Exibe os ingredientes traduzidos
        @display_instructions = translation.instructions # Exibe as instruções traduzidas
      end
    end
  end

  def new
    @recipe = Recipe.new # Cria uma nova instância de receita
  end

  def create
    @recipe = current_user.recipes.new(recipe_params) # Cria uma nova receita associada ao usuário logado

    unless @recipe.valid? # Verifica se a receita é válida
      render :new, status: :unprocessable_content # Renderiza o formulário novamente em caso de erro
      return # Interrompe a execução do método
    end

    begin # Inicia o bloco de tratamento de exceções

      service_response = RecipeGeneratorService.new(@recipe, I18n.locale).call # Chama o serviço para gerar a receita

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
