class AddSvgIdToRoute < ActiveRecord::Migration[5.0]
  def change
    add_column :routes, :svg_id, :integer
  end
end
