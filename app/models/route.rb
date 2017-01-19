class Route < ApplicationRecord
  belongs_to :city1, class_name: 'City'
  belongs_to :city2, class_name: 'City'
  validates :pieces, presence: true

  # TODO: Enforce Routes are unique.
end
