class TrainCarType < ApplicationRecord
  has_many :dealt_train_car
  validates :name, presence: true
  validates :total, presence: true
end
