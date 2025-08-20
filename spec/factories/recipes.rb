FactoryBot.define do
  factory :recipe do
    title { "Receita de Teste" }
    ingredients { "Ingrediente 1, Ingrediente 2" }
    instructions { "Passo 1, Passo 2" }

    association :user # Diz ao FactoryBot para criar e associar um User a esta receita, usando a fábrica de 'user' que acabamos de definir.
  end
end
