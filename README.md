*For the Portuguese version of this document, please scroll to the bottom. / Para a versão em português deste documento, por favor, role até o final.*

---

# EasyFood 🍳🤖

**Your daily kitchen inspiration, powered by Artificial Intelligence.**

EasyFood is a modern web application built with Ruby on Rails, designed to solve the daily dilemma of "what to cook?". Users provide a list of ingredients they have at home, and the application leverages the OpenAI API to generate creative recipes, complete with detailed instructions and a photorealistic image of the dish.

![EasyFood Demo](public/demo/easyfood_demo.gif)

---

## ✨ Core Features

* **AI-Powered Recipe Generation:** Utilizes OpenAI's GPT model to create titles and instructions for recipes from a simple list of ingredients.
* **AI-Powered Image Generation:** Uses the DALL-E 3 model to create a unique, photorealistic image for each generated recipe.
* **Permanent Image Storage:** Leverages Rails' Active Storage to download and permanently store the generated images, ensuring they never expire.
* **Responsive & Mobile-First UI:** Built with Bootstrap 5, the design is fully adapted for a seamless experience on mobile phones, tablets, and desktops.
* **Internationalization (I18n):** World-ready! The interface is translated into Portuguese, English, and Spanish, featuring a dynamic language switcher.
* **On-Demand Content Translation:** Existing recipes can be dynamically translated into other languages via AI on the first view, with a database caching system to ensure performance and cost control on subsequent visits.
* **User Authentication:** A complete system for user registration (with custom fields), login, and profile editing, built with the robust Devise gem.
* **Dynamic Home Page:** A showcase for visitors featuring "Popular Recipes" and an exclusive "Latest Recipes" section for logged-in members, encouraging sign-ups.
* **Interactive Feedback:** The application provides users with a "loading state" during AI calls, improving the user experience and preventing multiple submissions.
* **Test Coverage:** Critical business logic (models and controllers) is protected by automated tests using RSpec and FactoryBot.

## 🛠️ Tech Stack

* **Backend:**
    * Ruby on Rails 8.0.2
    * Ruby 3.3.5
    * Puma Web Server
* **Frontend:**
    * Importmaps
    * StimulusJS (for interactivity)
    * Turbo
    * Bootstrap 5
    * Sass (`cssbundling-rails`)
* **Database:**
    * PostgreSQL
* **Testing:**
    * RSpec
    * FactoryBot
* **External APIs:**
    * OpenAI (GPT-3.5-turbo for text, DALL-E 3 for images)
* **Notable Gems:**
    * Devise (authentication)
    * Active Storage (file management)
    * Foreman (process management)
    * `rails-i18n` & `devise-i18n` (internationalization)

---

## 🚀 Getting Started

Follow these instructions to get a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You will need the following tools installed on your system:
* Ruby (version is defined in the `.ruby-version` file)
* Bundler
* Node.js
* Yarn
* PostgreSQL

### Installation Guide

1.  **Clone the repository:**
    ```sh
    git clone https://github.com/henriqueamotta/EasyFood.git
    cd EasyFood
    ```

2.  **Install Ruby dependencies:**
    ```sh
    bundle install
    ```

3.  **Install JavaScript dependencies:**
    ```sh
    yarn install
    ```

4.  **Configure your environment variables:**
    Copy the example file. This file is ignored by Git to protect your secret keys.
    ```sh
    cp .env.example .env
    ```
    Now, edit the `.env` file and insert your OpenAI API key:
    ```
    OPENAI_API_KEY="sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    ```

5.  **Set up the database:**
    Copy the database configuration example file.
    ```sh
    cp config/database.yml.example config/database.yml
    ```
    Edit the `config/database.yml` file with your PostgreSQL username and password if necessary.

6.  **Create, migrate, and seed the database:**
    Ensure your PostgreSQL service is running. Then, execute the Rails setup command.
    ```sh
    rails db:setup
    ```
    This command will create the databases, run all migrations, and execute the seeds script (`db/seeds.rb`) to populate the application with sample data.

### Running the Application

To start the application in a development environment, use Foreman via the `bin/dev` script. It will start both the Rails server and the CSS watcher.

```sh
bin/dev
```

Open your browser and visit `http://localhost:3000`.

### Running Tests

To run the automated test suite and ensure everything is working as expected, run RSpec:

```sh
rspec
```

---

## ✒️ Author

* **Henrique Motta** - [GitHub](https://github.com/henriqueamotta) | [LinkedIn](https://linkedin.com/in/henriqueamotta/)

---
<br>

## 🇧🇷 Versão em Português-BR

# EasyFood 🍳🤖

**Sua inspiração diária na cozinha, potencializada por Inteligência Artificial.**

EasyFood é uma aplicação web moderna construída com Ruby on Rails, projetada para resolver o dilema diário do "o que cozinhar?". Usuários informam os ingredientes que têm em casa, e a aplicação utiliza a API da OpenAI para gerar receitas criativas, completas com instruções detalhadas e uma imagem fotorrealista do prato.

![Demonstração do EasyFood](public/demo/easyfood_demo.gif)

---

## ✨ Funcionalidades Principais

* **Geração de Receitas por IA:** Utiliza o modelo GPT da OpenAI para criar títulos e instruções de receitas a partir de uma simples lista de ingredientes.
* **Geração de Imagens por IA:** Utiliza o modelo DALL-E 3 para criar uma imagem fotorrealista e única para cada receita gerada.
* **Armazenamento Permanente de Imagens:** Usa o Active Storage do Rails para baixar e armazenar permanentemente as imagens, garantindo que elas nunca expirem.
* **Interface Responsiva e `Mobile-First`:** Construído com Bootstrap 5, o design é totalmente adaptado para uma experiência perfeita em celulares, tablets e desktops.
* **Internacionalização (I18n):** Pronto para o mundo! A interface está traduzida para Português, Inglês e Espanhol, com um seletor de idiomas dinâmico.
* **Tradução de Conteúdo Sob Demanda:** Receitas existentes são traduzidas para outros idiomas dinamicamente via IA na primeira visualização, com um sistema de cache no banco de dados para garantir performance e controle de custos nas visitas seguintes.
* **Autenticação de Usuários:** Sistema completo de cadastro (com campos personalizados), login, e edição de perfil, construído com a robusta gem Devise.
* **Página Home Dinâmica:** Uma vitrine para visitantes com "Receitas Populares" e uma seção exclusiva de "Últimas Receitas" para membros logados, incentivando o cadastro.
* **Feedback Interativo:** A aplicação informa o usuário com um "estado de carregamento" durante as chamadas à IA, melhorando a experiência do usuário e prevenindo múltiplas submissões.
* **Cobertura de Testes:** A lógica de negócio crítica (modelos e controllers) está protegida por testes automatizados usando RSpec e FactoryBot.

## 🛠️ Tecnologias Utilizadas

* **Backend:**
    * Ruby on Rails 8.0.2
    * Ruby 3.3.5
    * Puma Web Server
* **Frontend:**
    * Importmaps
    * StimulusJS
    * Turbo
    * Bootstrap 5
    * Sass (`cssbundling-rails`)
* **Banco de Dados:**
    * PostgreSQL
* **Testes:**
    * RSpec
    * FactoryBot
* **APIs Externas:**
    * OpenAI (GPT-3.5-turbo para texto, DALL-E 3 para imagens)
* **Gems Notáveis:**
    * Devise (autenticação)
    * Active Storage (gerenciamento de arquivos)
    * Foreman (gerenciamento de processos)
    * `rails-i18n` e `devise-i18n` (internacionalização)

---

## 🚀 Começando

Siga estas instruções para obter uma cópia do projeto e rodá-la na sua máquina local para desenvolvimento e testes.

### Pré-requisitos

Você precisará ter as seguintes ferramentas instaladas na sua máquina:
* Ruby (a versão está definida no arquivo `.ruby-version`)
* Bundler
* Node.js
* Yarn
* PostgreSQL

### Guia de Instalação

1.  **Clone o repositório:**
    ```sh
    git clone https://github.com/henriqueamotta/EasyFood.git
    cd EasyFood
    ```

2.  **Instale as dependências Ruby:**
    ```sh
    bundle install
    ```

3.  **Instale as dependências JavaScript:**
    ```sh
    yarn install
    ```

4.  **Configure suas variáveis de ambiente:**
    Copie o arquivo de exemplo. Este arquivo é ignorado pelo Git para proteger suas chaves secretas.
    ```sh
    cp .env.example .env
    ```
    Agora, edite o arquivo `.env` e insira sua chave da API da OpenAI:
    ```
    OPENAI_API_KEY="sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
    ```

5.  **Configure o banco de dados:**
    Copie o arquivo de exemplo de configuração do banco de dados.
    ```sh
    cp config/database.yml.example config/database.yml
    ```
    Edite o arquivo `config/database.yml` com o seu usuário e senha do PostgreSQL, se necessário.

6.  **Crie, migre e popule o banco de dados:**
    Certifique-se de que seu serviço PostgreSQL está rodando. Em seguida, execute o comando de setup do Rails.
    ```sh
    rails db:setup
    ```
    Este comando irá criar os bancos de dados, rodar todas as `migrations` e executar o script de `seeds` (`db/seeds.rb`) para popular a aplicação com dados de exemplo.

### Rodando a Aplicação

Para iniciar a aplicação em ambiente de desenvolvimento, use o Foreman através do script `bin/dev`. Ele iniciará tanto o servidor Rails quanto o compilador de CSS em modo de observação.

```sh
bin/dev
```

Abra seu navegador e visite `http://localhost:3000`.

### Rodando os Testes

Para executar a suíte de testes automatizados e garantir que tudo está funcionando como esperado, rode o RSpec:

```sh
rspec
```

---

## ✒️ Autor

* **Henrique Motta** - [GitHub](https://github.com/henriqueamotta) | [LinkedIn](https://linkedin.com/in/henriqueamotta/)
