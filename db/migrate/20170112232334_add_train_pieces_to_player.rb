class AddTrainPiecesToPlayer < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :train_pieces, :integer
  end
end
