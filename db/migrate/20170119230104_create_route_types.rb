class CreateRouteTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :route_types do |t|
      t.string :colour, null: false

      t.timestamps
    end
  end
end
