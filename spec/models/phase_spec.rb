require 'rails_helper'

RSpec.describe Phase, type: :model do
  describe 'validatation' do
    it { is_expected.to belong_to(:tournament) }
    it { is_expected.to validate_inclusion_of(:type).in_array(Phase::TYPES) }
    it { is_expected.to validate_numericality_of(:position_in_tournament).is_greater_than(0) }

    describe "uniqueness" do
      subject { build(:phase) }
      it { is_expected.to validate_uniqueness_of(:position_in_tournament).scoped_to(:tournament_id) }
    end
  end

  describe 'scopes' do
    describe 'default scope' do
      let(:tournament) { create(:tournament) }
      let!(:phase2) { create(:default_phase, tournament: tournament, position_in_tournament: 2) }
      let!(:phase1) { create(:default_phase, tournament: tournament, position_in_tournament: 1) }
      let!(:phase3) { create(:default_phase, tournament: tournament, position_in_tournament: 3) }

      it 'orders the phases based on the given' do
        expect(tournament.phases.to_a).to eq [phase1, phase2, phase3]
      end

      it 'does not order the phases based on their creation date' do
        expect(tournament.phases.to_a).not_to eq [phase2, phase1, phase3]
        expect(tournament.phases.to_a).not_to eq [phase3, phase1, phase2]
      end
    end
  end
end
