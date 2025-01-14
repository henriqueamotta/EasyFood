Rails.application.routes.draw do
  resources :ingredients, only: [:index, :new, :create]
  resources :recipes, only: [:index, :show]
  root to: "pages#home"
end
