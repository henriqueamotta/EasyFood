class PagesController < ApplicationController
  def home
    # Encontra os 5 ingredientes mais utilizados em todas as receitas
    all_ingredients = Recipe.pluck(:ingredients).flat_map { |ing| ing.split(/,\s*/) } # Obtem todos os ingredientes
    ingredients_counts = all_ingredients.tally # Conta a ocorrência de cada ingrediente
    @top_ingredients = ingredients_counts.sort_by { |_, count| -count }.first(5).to_h # Ordena e pega os 5 mais utilizados

    # Encontra receitas que usam os 5 ingredientes mais utilizados
    @top_ingredients_names = @top_ingredients.keys # Obtem os nomes dos ingredientes
    query_string = @top_ingredients_names.map { |ing| "ingredients ILIKE ?" }.join(" OR ") # Cria a string de consulta. Usamos 'ILIKE' para ignorar maiúsculas/minúsculas
    query_values = @top_ingredients_names.map { |ing| "%#{ing}%" } # Cria os valores da consulta
    popular_candidates = Recipe.where(query_string, *query_values).limit(20) # Seleciona as 20 receitas mais populares

    @popular_recipes = popular_candidates.sample(6) # Seleciona aleatoriamente 6 receitas entre as candidatas

    # Encontra as 3 receitas mais recentes que não estão entre as populares
    popular_recipes_ids = @popular_recipes.pluck(:id) # Obtem os IDs das receitas populares
    @latest_recipes = Recipe.where.not(id: popular_recipes_ids).order(created_at: :desc).limit(3) # Seleciona as 3 receitas mais recentes que não estão entre as populares
  end

  def about
  end
end
