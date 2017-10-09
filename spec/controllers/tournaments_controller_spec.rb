require 'rails_helper'

RSpec.describe TournamentsController, type: :controller do
  let(:valid_attributes) { attributes_for(:tournament) }
  let(:invalid_attributes) { valid_attributes.merge(required_teams: 0) }
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    let(:tournament) { create(:tournament) }
    it "returns a success response" do
      get :edit, params: {id: tournament.to_param}, session: valid_session
      expect(response).to be_success
    end
  end


  context 'only tournament info' do
    describe "POST #create" do
      context "with valid params" do
        it "redirects to the created tournament" do
          post :create, params: {tournament: valid_attributes}, session: valid_session
          expect(response).to redirect_to tournaments_path
        end

        it "creates a new Tournament" do
          expect {
            post :create, params: {tournament: valid_attributes}, session: valid_session
          }.to change(Tournament, :count).by(1)
        end
      end

      context "with invalid params" do
        it "returns a success response" do
          post :create, params: {tournament: invalid_attributes}, session: valid_session
          expect(response).to be_success
        end

        it "does not create a new Tournament" do
          expect {
            post :create, params: {tournament: invalid_attributes}, session: valid_session
          }.not_to change(Tournament, :count)
        end
      end
    end

    describe "PUT #update" do
      let(:tournament) { create(:tournament) }

      context "with valid params" do
        let(:new_attributes) { { name: 'The new kuppa cup' } }

        it "updates the requested tournament" do
          put :update, params: {id: tournament.to_param, tournament: new_attributes},
            session: valid_session

          tournament.reload
          expect(tournament.name).to eq new_attributes[:name]
        end

        it "redirects to the tournament" do
          put :update, params: {id: tournament.to_param, tournament: valid_attributes},
            session: valid_session

          expect(response).to redirect_to tournaments_path
        end
      end

      context "with invalid params" do
        it "returns a success response (i.e. to display the 'edit' template)" do
          put :update, params: {id: tournament.to_param, tournament: invalid_attributes},
            session: valid_session

          expect(response).to be_success
        end
      end
    end

    describe "DELETE #destroy" do
      let!(:tournament) { create(:tournament) }

      it "destroys the requested tournament" do
        expect {
          delete :destroy, params: {id: tournament.to_param}, session: valid_session
        }.to change(Tournament, :count).by(-1)
      end

      it "redirects to the tournaments list" do
        delete :destroy, params: {id: tournament.to_param}, session: valid_session
        expect(response).to redirect_to tournaments_path
      end
    end
  end

  context 'tournament and contestants info' do
    let(:team1) { create(:team) }
    let(:team2) { create(:team) }

    describe "POST #create" do
      context 'with valid params for tournament contestants' do
        let(:attributes_with_contestants) do
          valid_attributes.merge(
            contestants_attributes: [{team_id: team1.id}, {team_id: team2.id}]
          )
        end

        it "returns a success response" do
          post :create, params: {tournament: attributes_with_contestants},
            session: valid_session

          expect(response).to redirect_to tournaments_path
        end

        it "creates a new tournament" do
          expect {
            post :create, params: {tournament: attributes_with_contestants},
              session: valid_session
          }.to change(Tournament, :count).by(1)
        end

        it "creates the new the tournament contestants" do
          expect {
            post :create, params: {tournament: attributes_with_contestants},
              session: valid_session
          }.to change(Tournament::Contestant, :count).by(2)
        end
      end

      context "with invalid params for contestans" do
        let(:attributes_with_contestants) do
          valid_attributes.merge(
            contestants_attributes: [{team_id: team1.id}, {team_id: team1.id}]
          )
        end

        it "returns a success response" do
          post :create, params: {tournament: attributes_with_contestants},
            session: valid_session

          expect(response).to be_success
        end

        it "creates a new tournament" do
          expect {
            post :create, params: {tournament: attributes_with_contestants},
              session: valid_session
          }.not_to change(Tournament, :count)
        end

        it "creates the new the tournament contestants" do
          expect {
            post :create, params: {tournament: attributes_with_contestants},
              session: valid_session
          }.not_to change(Tournament::Contestant, :count)
        end
      end
    end

    describe "PUT #update" do
      let(:tournament) { create(:tournament) }
      let!(:contestant1) { create(:contestant, tournament: tournament, team: team1) }
      let!(:contestant2) { create(:contestant, tournament: tournament, team: team2) }

      context "with valid params" do
        let(:team3) { create(:team) }
        let(:attributes_with_contestants) do
          valid_attributes.merge(
            contestants_attributes: [
              {id: contestant1.id, team_id: team1.id},
              {id: contestant2.id, team_id: team3.id}
            ]
          )
        end

        it "updates the requested tournament teams" do
          put :update, params: {id: tournament.to_param, tournament: attributes_with_contestants},
            session: valid_session

          tournament.reload
          expect(tournament.teams).to eq [team1, team3]
        end

        it "redirects to the tournament" do
          put :update, params: {id: tournament.to_param, tournament: attributes_with_contestants},
            session: valid_session

          expect(response).to redirect_to tournaments_path
        end

        it 'deletes the requested contestant' do
          deleted_contestant = valid_attributes.merge(
            contestants_attributes: [
              {id: contestant1.id, team_id: team1.id},
              {id: contestant2.id, team_id: team2.id, _destroy: "true"}
            ]
          )

          put :update, params: {id: tournament.to_param, tournament: deleted_contestant},
            session: valid_session, as: :json

          expect(tournament.teams.to_a).to eq [team1]
        end
      end

      context "with invalid params" do
        let(:attributes_with_contestants) do
          valid_attributes.merge(
            contestants_attributes: [
              {id: contestant1.id, team_id: team1.id},
              {id: contestant2.id, team_id: team1.id}
            ]
          )
        end

        it "returns a success response" do
          put :update, params: {id: tournament.to_param, tournament: attributes_with_contestants},
            session: valid_session

          expect(response).to be_success
        end

        it "does not update the tournament teams" do
          put :update, params: {id: tournament.to_param, tournament: attributes_with_contestants},
            session: valid_session

          tournament.reload
          expect(tournament.teams.pluck(:id)).to eq [team1.id, team2.id]
        end
      end
    end

    describe "DELETE #destroy" do
      let!(:tournament) { create(:tournament) }
    end
  end
end
