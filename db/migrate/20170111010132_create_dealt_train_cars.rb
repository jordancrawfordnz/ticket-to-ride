class CreateDealtTrainCars < ActiveRecord::Migration[5.0]
  def change
    create_table :dealt_train_cars do |t|
      t.references :player, foreign_key: true
      
      t.timestamps
    end
  end
end
