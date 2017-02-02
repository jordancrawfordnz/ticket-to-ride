class ChangeScoreFormatInPlayers < ActiveRecord::Migration[5.0]
  def change
    change_column :players, :score, :integer
  end
end
