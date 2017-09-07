class Phase < ApplicationRecord
  TYPES = [
    :default,
    :cumulative,
    :group_elimination,
    :single_elimination
  ]

  validates :type, inclusion: { in: Phase::TYPES }
end
