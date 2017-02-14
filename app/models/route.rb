class Route < ApplicationRecord
  belongs_to :city1, class_name: 'City'
  belongs_to :city2, class_name: 'City'
  belongs_to :route_type
  has_many :route_claims

  validates :pieces, presence: true,
    :numericality => { :greater_than => 0,
                       :less_than_or_equal_to => 6
                     }

  validates :svg_id, presence: true, uniqueness: true

  validate :cities_ordered_correctly

  # TODO: This is killing speed. Turn this into an association.
  def claimed_route_for_game(game)
    route_claims.joins(:player).merge(game.players).first
  end

  def cities_ordered_correctly
    return if (!city1 || !city2)

    if !city1.id || !city2.id
      errors.add(:base, 'Both cities must have IDs.')
    elsif city1.id == city2.id
      errors.add(:base, 'Both cities must be different.')
    elsif city1.id > city2.id
      errors.add(:base, 'city1 must have a lower index than city2')
    end
  end

  def alternate_city(compare_city)
    if city1 == compare_city
      city2
    elsif city2 == compare_city
      city1
    end
  end
end
