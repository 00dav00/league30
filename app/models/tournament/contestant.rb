class Tournament::Contestant < ApplicationRecord
  belongs_to :tournament, counter_cache: true
  belongs_to :team

  validates :tournament, presence: true
  validates :team, presence: true
end
