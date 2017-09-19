class Team < ApplicationRecord
  validates :short_name, presence: true
  validates :name, presence: true
  validates :full_name, presence: true

  mount_uploader :logo_image, TeamLogoUploader
end
