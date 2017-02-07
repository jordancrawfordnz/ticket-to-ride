class Game < ApplicationRecord
  has_many :players, dependent: :destroy
  has_many :dealt_train_cars, through: :players
  belongs_to :current_player, class_name: 'Player'

  validates :current_player, presence: true
end
