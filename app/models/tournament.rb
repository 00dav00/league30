class Tournament < ApplicationRecord
  has_many :phases
  has_many :contestants, inverse_of: :tournament
  has_many :teams, through: :contestants

  validates :name, presence: true
  validates :required_teams, presence: true
  validates :active, presence: true
  validates :required_teams, numericality: { greater_than: 1 }
  validate :teams_not_repeated

  accepts_nested_attributes_for :contestants, reject_if: :all_blank, allow_destroy: true

  private

  def teams_not_repeated
    unless nested_team_ids.size == nested_team_ids.uniq.size
      errors.add(:contestants, "Repeated contestants")
    end
  end

  def nested_team_ids
    contestants.reject(&:marked_for_destruction?).map(&:team_id)
  end
end
