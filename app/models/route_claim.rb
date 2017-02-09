class RouteClaim < ApplicationRecord
  belongs_to :player
  belongs_to :route
  has_one :game, through: :player
end
