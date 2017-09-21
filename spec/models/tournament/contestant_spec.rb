require 'rails_helper'

RSpec.describe Tournament::Contestant, type: :model do
  describe 'validations' do
    it { is_expected.to belong_to(:tournament) }
    it { is_expected.to belong_to(:team) }

    it { is_expected.to validate_presence_of(:tournament) }
    it { is_expected.to validate_presence_of(:team) }
    it { is_expected.to validate_uniqueness_of(:team_id).scoped_to(:tournament_id) }
    it { is_expected.to validate_uniqueness_of(:tournament_id).scoped_to(:team_id) }
  end
end
