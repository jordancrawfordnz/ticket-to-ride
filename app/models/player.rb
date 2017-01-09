class Player < ApplicationRecord
  belongs_to :game
  validates :name, presence: true
  validates :colour, presence: true, uniqueness: { scope: :game }
  validates :game, presence: true
end
