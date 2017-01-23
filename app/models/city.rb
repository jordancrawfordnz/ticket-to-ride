class City < ApplicationRecord
  validates :name, presence: true
  has_many :destinations
  has_many :sources

  def routes
    Route.where(city1: self).or(Route.where(city2: self))
  end

  def destinations
    routes.map do |route|
      route.alternate_city(self)
    end
  end
end
