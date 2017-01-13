class Player < ApplicationRecord
  belongs_to :game
  has_many :dealt_train_cars, dependent: :destroy
  validates :name, presence: true
  validates :colour, presence: true, uniqueness: { scope: :game }
  validates :game, presence: true
  validates :train_pieces, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
end
