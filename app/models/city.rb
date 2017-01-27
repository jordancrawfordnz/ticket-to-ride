class City < ApplicationRecord
  validates :name, presence: true
  has_many :destinations
  has_many :sources

  # TODO: When I get a chance, make routes into a proper relation. This may be difficult!

  def routes
    Route.includes(:route_type, :city1, :city2).where(city1: self) + Route.includes(:route_type, :city1, :city2).where(city2: self)
  end

  def destinations
    routes.map do |route|
      route.alternate_city(self)
    end
  end
end
