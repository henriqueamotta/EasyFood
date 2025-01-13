Rails.application.routes.draw do
  resources :ingredients, only: [:index, :new, :create]
  root to: "pages#home"
end
