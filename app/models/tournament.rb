class Tournament < ApplicationRecord
  has_many :phases
  has_many :contestants
  has_many :teams, through: :contestants

  validates :name, presence: true
  validates :required_teams, presence: true
  validates :active, presence: true

  validates :required_teams, numericality: { greater_than: 1 }
end
