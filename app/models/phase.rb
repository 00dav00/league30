class Phase < ApplicationRecord
  TYPES = {
    default: 'DefaultPhase',
    cumulative: 'CumulativePhase',
    single_elimination: 'SingleEliminationPhase'
    # 'GroupEliminationPhase',
  }

  belongs_to :tournament

  validates :type, inclusion: { in: Phase::TYPES.values }
  validates :position_in_tournament, numericality: { greater_than: 0 }
  validates :position_in_tournament, uniqueness: { scope: :tournament_id }

  default_scope { order(position_in_tournament: :asc) }

  def self.build_phase_for(tournament, params)
    raise ArgumentError unless tournament.present?

    new(
      params.merge!(
        tournament: tournament,
        position_in_tournament: tournament.phases.count + 1
      )
    )
  end
end
