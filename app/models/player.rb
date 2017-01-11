class Player < ApplicationRecord
  belongs_to :game
  has_many :dealt_train_cars, dependent: :destroy
  validates :name, presence: true
  validates :colour, presence: true, uniqueness: { scope: :game }
  validates :game, presence: true
end
