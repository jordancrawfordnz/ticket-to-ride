class Player < ApplicationRecord
  belongs_to :game
  validates :name, presence: true
  validates :colour, presence: true
  validates :game, presence: true
end
