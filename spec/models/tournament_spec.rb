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

    describe '.teams_not_repeated' do
      let(:team1) { create(:team) }
      let(:team2) { create(:team) }

      describe 'on creation' do
        subject { described_class.new(attributes) }

        context 'when nested attributes try to create contestants with different teams' do
          let(:attributes) do
            attributes_for(:tournament).merge(
              contestants_attributes: [{ team_id: team1.id }, { team_id: team2.id }]
            )
          end
          it { is_expected.to be_valid }
        end

        context 'when nested attributes try to create contestants with the same team' do
          let(:attributes) do
            attributes_for(:tournament).merge(
              contestants_attributes: [{ team_id: team1.id }, { team_id: team1.id }]
            )
          end
          it { is_expected.not_to be_valid }
        end
      end

      describe 'on update' do
        let(:tournament) { create(:tournament) }
        let!(:contestant1) { create(:contestant, team: team1, tournament: tournament) }
        let!(:contestant2) { create(:contestant, team: team2, tournament: tournament) }

        subject { tournament.reload.update!(attributes) }

        context 'when nested attributes try to update contestants with different teams' do
          let(:team3) { create(:team) }
          let(:attributes) do
            attributes_for(:tournament).merge(
              contestants_attributes: [
                { id: contestant1.id, team_id: team1.id},
                { id: contestant2.id, team_id: team3.id}
              ]
            )
          end

          it { is_expected.to be_truthy }

          it 'changes the tournament contestants' do
            expect{ subject }.to change { tournament.teams.to_a }
              .from([team1, team2])
              .to([team1, team3])
          end
        end

        context 'when nested attributes try to update contestants with the same team' do
          let(:attributes) do
            attributes_for(:tournament).merge(
              contestants_attributes: [
                { id: contestant1.id, team_id: team1.id},
                { id: contestant2.id, team_id: team1.id}
              ]
            )
          end

          it 'raises an error' do
            expect{ subject }.to raise_error ActiveRecord::RecordInvalid
          end
        end
      end

      describe 'on delete' do
        let(:tournament) { create(:tournament) }
        let!(:contestant1) { create(:contestant, team: team1, tournament: tournament) }
        let!(:contestant2) { create(:contestant, team: team2, tournament: tournament) }

        subject { tournament.reload.update!(attributes) }

        context 'when deleting a contestant without adding a new one' do
          let(:attributes) do
            attributes_for(:tournament).merge(
              contestants_attributes: [
                { id: contestant1.id, team_id: team1.id },
                { id: contestant2.id, team_id: team2.id, _destroy: true }
              ]
            )
          end

          it { is_expected.to be_truthy }

          it 'destroys the selected tournament contestants' do
            expect{ subject }.to change { tournament.teams.to_a }
              .from([team1, team2])
              .to([team1])
          end
        end

        context 'when deleting a contestant and adding it again at time' do
          let(:attributes) do
            attributes_for(:tournament).merge(
              contestants_attributes: [
                { id: contestant1.id, team_id: team1.id },
                { id: contestant2.id, team_id: team2.id, _destroy: true },
                { team_id: team2.id }
              ]
            )
          end

          it { is_expected.to be_truthy }

          it 'recreates the contestants with the same teams' do
            expect{ subject }.not_to change { tournament.teams.to_a }
          end

          it 'changes the association records for the contestants' do
            expect{ subject }.to change { tournament.contestants.to_a }
          end
        end
      end
    end
  end
end
