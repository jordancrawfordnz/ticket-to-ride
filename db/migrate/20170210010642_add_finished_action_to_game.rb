class AddFinishedActionToGame < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :finished_action, :boolean
  end
end
