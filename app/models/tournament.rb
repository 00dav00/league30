class Tournament < ApplicationRecord
  validates :name, presence: true
  validates :required_teams, presence: true
  validates :active, presence: true

  validates :required_teams, numericality: { greater_than: 1 }
end