class Team < ApplicationRecord
  has_many :tournament_participations, class_name: 'Tournament::Contestant'

  validates :short_name, presence: true
  validates :name, presence: true
  validates :full_name, presence: true

  mount_uploader :logo_image, TeamLogoUploader
end
