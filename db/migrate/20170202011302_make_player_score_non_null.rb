class MakePlayerScoreNonNull < ActiveRecord::Migration[5.0]
  def change
    change_column_null :players, :score, false
  end
end
