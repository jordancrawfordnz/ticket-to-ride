class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :dealt_train_cars, through: :players

  def current_player
    players.first
  end
end
