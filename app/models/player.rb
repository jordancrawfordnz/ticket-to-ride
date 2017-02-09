class Player < ApplicationRecord
  belongs_to :game
  has_many :dealt_train_cars, dependent: :destroy
  has_many :route_claim

  validates :name, presence: true
  validates :colour, presence: true, uniqueness: { scope: :game }
  validates :game, presence: true
  validates :score, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
  validates :train_pieces, presence: true, :numericality => { :greater_than_or_equal_to => 0 }
end
