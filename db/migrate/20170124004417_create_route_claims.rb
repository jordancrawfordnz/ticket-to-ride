class CreateRouteClaims < ActiveRecord::Migration[5.0]
  def change
    create_table :route_claims do |t|
      t.references :player
      t.references :route

      t.timestamps
    end
  end
end
