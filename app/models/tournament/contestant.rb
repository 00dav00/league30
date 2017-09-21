class Tournament::Contestant < ApplicationRecord
  belongs_to :tournament, counter_cache: true
  belongs_to :team

  validates :tournament, presence: true
  validates :team, presence: true
  validates :team_id, uniqueness: { scope: :tournament_id }
  validates :tournament_id, uniqueness: { scope: :team_id }
end
