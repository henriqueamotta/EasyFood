Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :ingredients, only: [:index, :new, :create]
  resources :recipes, only: [:index, :show]
  root to: "pages#home"
end
