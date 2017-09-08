class Phase < ApplicationRecord
  TYPES = [
    :default,
    :cumulative,
    :group_elimination,
    :single_elimination
  ]

  belongs_to :tournament
  validates :type, inclusion: { in: Phase::TYPES.map(&:to_s) }
  validates :position_in_tournament, numericality: { greater_than: 0 }
  validates :position_in_tournament, uniqueness: { scope: :tournament_id }
end
