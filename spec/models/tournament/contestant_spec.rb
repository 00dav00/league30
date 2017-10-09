require 'rails_helper'

RSpec.describe Tournament::Contestant, type: :model do
  describe 'validations' do
    it { is_expected.to belong_to(:tournament) }
    it { is_expected.to belong_to(:team) }

    it { is_expected.to validate_presence_of(:tournament) }
    it { is_expected.to validate_presence_of(:team) }
  end
end
