class AddTrainCarTypeToDealtTrainCars < ActiveRecord::Migration[5.0]
  def change
    add_reference :dealt_train_cars, :train_car_type, foreign_key: true
  end
end
