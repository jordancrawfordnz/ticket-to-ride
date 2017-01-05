Rails.application.routes.draw do
  resources :games, only: [:index, :new, :create, :show]

  root 'games#index'
end
