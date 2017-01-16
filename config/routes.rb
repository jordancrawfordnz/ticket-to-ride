Rails.application.routes.draw do
  resources :games, only: [:index, :new, :create, :show]
  match "/games/:id/draw_train_cars" => "games#draw_train_cars", via: :post

  root 'games#new'
end
