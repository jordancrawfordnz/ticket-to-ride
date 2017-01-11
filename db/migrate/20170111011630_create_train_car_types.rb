class CreateTrainCarTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :train_car_types do |t|
      t.string :name, null: false
      t.integer :total, null: false

      t.timestamps
    end
  end
end
