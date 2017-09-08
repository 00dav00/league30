require 'rails_helper'

RSpec.describe Phase, type: :model do
  describe 'validatation' do
    it { is_expected.to belong_to(:tournament) }
    it { is_expected.to validate_inclusion_of(:type).in_array(Phase::TYPES) }
    it { is_expected.to validate_numericality_of(:position_in_tournament).is_greater_than(0) }

    describe "uniqueness" do
      subject { FactoryGirl.build(:phase) }
      it { is_expected.to validate_uniqueness_of(:position_in_tournament).scoped_to(:tournament_id) }
    end
  end
end
