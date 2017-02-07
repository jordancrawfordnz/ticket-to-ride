class AddCurrentPlayerToGame < ActiveRecord::Migration[5.0]
  def change
    add_reference :games, :current_player, foreign_key: true
  end
end
