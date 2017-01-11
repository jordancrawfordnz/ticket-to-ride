class DealtTrainCar < ApplicationRecord
  belongs_to :player
  belongs_to :train_car_type
  validates :player, presence: true
  validates :train_car_type, presence: true
end
