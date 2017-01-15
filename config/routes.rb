Rails.application.routes.draw do
  resources :games, only: [:index, :new, :create, :show]
  post "/games/:id/draw_train_cars" => "games#draw_train_cars"

  root 'games#new'
end
