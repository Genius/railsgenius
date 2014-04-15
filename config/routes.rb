RapgeniusLite::Application.routes.draw do
  root to: 'static#index'

  get 'users/edit', to: 'users#edit', as: :edit_current_user
  devise_for :users
  resources :users

  resources :talks do
    resources :annotations, only: [:create]

    member do
      resources :contributors, only: :index
      get 'annotations/:annotation_id', action: :show, as: 'expanded_annotation'
      get 'annotations/:annotation_id/edit', action: :show, as: 'expanded_annotation_edit', edit: true
    end
  end

  get '/:id', to: 'annotations#show', constraints: { id: /\d+/ }
  resources :annotations do
    member do
      get 'tooltip'
    end
  end
end
