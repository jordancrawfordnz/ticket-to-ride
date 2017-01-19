class City < ApplicationRecord
  validates :name, presence: true
  has_many :destinations
  has_many :sources

  def routes
    Route.where(city1: self).or(Route.where(city2: self))
  end
end
