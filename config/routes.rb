RapgeniusLite::Application.routes.draw do
  devise_for :users
  root to: 'static#index'
end
