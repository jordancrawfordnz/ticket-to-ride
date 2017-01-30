class City < ApplicationRecord
  validates :name, presence: true
  has_many :where_city_1, foreign_key: :city1_id, class_name: 'Route'
  has_many :where_city_2, foreign_key: :city2_id, class_name: 'Route'

  def routes
    fields_to_include = [:route_type, :city1, :city2, :route_claim]
    where_city_1.includes(fields_to_include) + where_city_2.includes(fields_to_include)
  end

  def destinations
    routes.map do |route|
      route.alternate_city(self)
    end
  end
end
