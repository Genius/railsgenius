RapgeniusLite::Application.routes.draw do
  root to: 'static#index'

  get 'users/edit', to: 'users#edit', as: :edit_current_user
  devise_for :users
  resources :users

  resources :talks do
    resources :annotations, only: [:create, :show, :edit, :update, :destroy]

    member do
      resources :contributors, only: :index
    end
  end
end
