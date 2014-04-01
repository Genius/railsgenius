RapgeniusLite::Application.routes.draw do
  root to: 'static#index'

  get 'users/edit', to: 'users#edit', as: :edit_current_user
  devise_for :users
  resources :users
end
