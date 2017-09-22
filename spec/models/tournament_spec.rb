require 'rails_helper'

RSpec.describe Tournament, type: :model do
  describe 'validations' do
    it { is_expected.to have_many(:phases) }
    it { is_expected.to have_many(:contestants) }
    it { is_expected.to have_many(:teams).through(:contestants) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:required_teams) }
    it { is_expected.to validate_presence_of(:active) }

    it { is_expected.to validate_numericality_of(:required_teams).is_greater_than(1) }
  end
end
