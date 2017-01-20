class AddRouteTypeToRoutes < ActiveRecord::Migration[5.0]
  def change
    add_reference :routes, :route_type, foreign_key: true
  end
end
