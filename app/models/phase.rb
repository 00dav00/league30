class Phase < ApplicationRecord
  TYPES = [
    'DefaultPhase',
    'CumulativePhase',
    'SingleEliminationPhase'
    # 'GroupEliminationPhase',
  ]

  belongs_to :tournament

  validates :type, inclusion: { in: Phase::TYPES.map(&:to_s) }
  validates :position_in_tournament, numericality: { greater_than: 0 }
  validates :position_in_tournament, uniqueness: { scope: :tournament_id }

  default_scope { order(position_in_tournament: :asc) }
end
