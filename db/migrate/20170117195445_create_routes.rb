class CreateRoutes < ActiveRecord::Migration[5.0]
  def change
    create_table :routes do |t|
      t.integer :pieces, null: false
      t.references :city1, foreign_key: {to_table: :city}, null: false
      t.references :city2, foreign_key: {to_table: :city}, null: false

      t.timestamps
    end
  end
end
