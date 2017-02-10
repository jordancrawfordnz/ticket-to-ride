Rails.application.routes.draw do
  resources :games, only: [:index, :new, :create, :show] do
    resources :claim_route, only: [:new, :create]
    resources :draw_train_cars, only: [:create]
    resources :finish_turn, only: [:create]
  end

  root 'games#new'
end
