class CreatePlayers < ActiveRecord::Migration[5.0]
  def change
    create_table :players do |t|
      t.text :name
      t.numeric :score
      t.text :colour
      t.references :game, foreign_key: true

      t.timestamps
    end
  end
end
