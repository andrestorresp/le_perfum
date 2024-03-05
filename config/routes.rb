# config/routes.rb
Rails.application.routes.draw do
  # Devise routes
  devise_for :users

  # Ruta raíz
  root to: "pages#home"

  # Rutas de productos
  resources :products do
    resources :reviews, only: :create
    resources :checkouts, only: %i[new create]
  end
  resources :checkouts, except: %i[new create]
  # Ruta para la acción principal

  get '/user_checkouts', to: 'checkouts#user_checkouts', as: 'user_checkouts'


end
