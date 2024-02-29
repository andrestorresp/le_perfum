# config/routes.rb
Rails.application.routes.draw do
  # Devise routes
  devise_for :users

  # Ruta raíz
  root to: "pages#home"

  # Rutas de productos
  resources :products do
    resources :reviews
    resources :checkouts
  end

  # Ruta para la acción principal
end
