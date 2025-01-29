Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  resources :ingredients, only: [:index, :new, :create]
  resources :recipes, only: [:index, :show, :new, :create]
  root to: "pages#home"
end
