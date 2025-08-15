require "open-uri"

puts "Limpando o banco de dados..."
# Garante que os arquivos anexados também sejam limpos
ActiveStorage::Attachment.all.each { |attachment| attachment.purge }
Recipe.destroy_all
User.destroy_all

puts "Criando usuários de exemplo..."
user1 = User.create!(name: "Henrique Motta", email: "henrique@example.com", password: "password")
user2 = User.create!(name: "Chef da Casa", email: "chef@example.com", password: "password")

puts "Criando receitas de exemplo com imagens..."

# Função auxiliar para anexar imagens locais
def attach_image(recipe, filename)
  image_path = Rails.root.join("app", "assets", "images", "seeds", filename)
  if File.exist?(image_path)
    content_type = filename.ends_with?(".png") ? "image/png" : "image/jpeg"
    recipe.photo.attach(
      io: File.open(image_path),
      filename: filename,
      content_type: content_type
    )
    puts "Anexada imagem '#{filename}' para a receita '#{recipe.title}'."
  else
    puts "AVISO: Imagem '#{filename}' não encontrada..."
  end
end

# --- Receitas com os ingredientes ---

recipe1 = Recipe.create!(
  user: user1,
  title: "Frango Grelhado Simples",
  ingredients: "filé de frango, alho, limão, sal, arroz",
  instructions: "1. Tempere o filé de frango com alho, limão e sal. 2. Grelhe em uma frigideira quente. 3. Sirva com arroz branco."
)
attach_image(recipe1, "frango_grelhado.png")

recipe2 = Recipe.create!(
  user: user2,
  title: "Carne Moída com Batatas",
  ingredients: "carne moída, batata, cebola, alho, tomate, arroz",
  instructions: "1. Refogue a carne moída com cebola e alho. 2. Adicione o tomate e as batatas picadas. 3. Cozinhe até as batatas ficarem macias. 4. Sirva com arroz."
)
attach_image(recipe2, "carne_moida.png")

recipe3 = Recipe.create!(
  user: user1,
  title: "Arroz de Carreteiro com Linguiça",
  ingredients: "linguiça toscana, arroz, cebola, pimentão, cheiro-verde",
  instructions: "1. Frite a linguiça toscana em pedaços. 2. Adicione a cebola e o pimentão e refogue. 3. Junte o arroz e cozinhe normalmente. 4. Finalize com cheiro-verde."
)
attach_image(recipe3, "arroz_de_carreteiro.png")

recipe4 = Recipe.create!(
  user: user2,
  title: "Picadinho de Acém",
  ingredients: "acém, cebola, alho, pimentão, caldo de carne, arroz",
  instructions: "1. Corte o acém em cubos e doure na panela. 2. Adicione os temperos e o caldo. 3. Cozinhe na pressão por 25 min. 4. Sirva com arroz."
)
attach_image(recipe4, "picadinho_de_acem.png")

recipe5 = Recipe.create!(
  user: user1,
  title: "Escondidinho de Carne Moída",
  ingredients: "carne moída, mandioca, queijo parmesão, manteiga, leite",
  instructions: "1. Cozinhe e amasse a mandioca para fazer um purê. 2. Refogue a carne moída. 3. Monte em uma travessa com o purê por cima. 4. Polvilhe queijo e leve ao forno para gratinar."
  )
  attach_image(recipe5, "escondidinho.png")

  recipe6 = Recipe.create!(
    user: user2,
    title: "Linguiça Toscana Acebolada",
    ingredients: "linguiça toscana, cebola, pão francês",
    instructions: "1. Asse ou frite a linguiça. 2. Fatie e misture com rodelas de cebola refogadas. 3. Sirva como aperitivo ou no pão."
    )
    attach_image(recipe6, "linguica_acebolada.png")

    recipe7 = Recipe.create!(
      user: user1,
      title: "Strogonoff de Filé de Frango",
      ingredients: "filé de frango, creme de leite, ketchup, mostarda, champignon, arroz, batata palha",
      instructions: "1. Doure o frango em cubos. 2. Adicione os demais ingredientes e misture bem. 3. Sirva com arroz e batata palha."
      )
# Reutilizando uma imagem para o exemplo
attach_image(recipe7, "frango_grelhado.png")

puts "Banco de dados populado com sucesso!"
puts "#{User.count} usuários e #{Recipe.count} receitas criados."
