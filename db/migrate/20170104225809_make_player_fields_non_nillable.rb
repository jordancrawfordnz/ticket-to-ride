class MakePlayerFieldsNonNillable < ActiveRecord::Migration[5.0]
  def change
    change_column_null :players, :name, false
    change_column_null :players, :colour, false
    change_column_null :players, :game_id, false
  end
end
