require 'rails_helper'

RSpec.describe PhasesController, type: :controller do
  let!(:tournament) { create(:tournament) }
  let(:valid_attributes) { attributes_for(:phase, tournament_id: tournament.id) }
  let(:invalid_attributes) { { position_in_tounament: 0 } }

  let(:valid_session) { {} }

  describe "GET #index" do
    let(:phase) { create(:phase, valid_attributes) }

    it "returns a success response" do
      get :index, params: { tournament_id: tournament.id }, session: valid_session

      expect(response).to be_success
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: { tournament_id: tournament.id }, session: valid_session
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    let(:phase) { Phase.create! valid_attributes }

    it "returns a success response" do
      get :edit, params: {id: phase.to_param}, session: valid_session
      expect(response).to be_success
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Phase" do
        expect {
          post :create,
            params: {phase: valid_attributes, tournament_id: tournament.id},
            session: valid_session
        }.to change(Phase, :count).by(1)
      end

      it "redirects to the created phase" do
        post :create,
          params: {phase: valid_attributes, tournament_id: tournament.id},
          session: valid_session
        expect(response).to redirect_to tournament_phases_path(tournament)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create,
          params: {phase: invalid_attributes, tournament_id: tournament.id},
          session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) { {name: 'New Name'} }
      let(:phase) { Phase.create! valid_attributes }

      it "updates the requested phase" do
        put :update,
          params: {id: phase.to_param, phase: new_attributes},
          session: valid_session
        phase.reload
        expect(phase.name).to eq new_attributes[:name]
      end

      it "redirects to tournaments phases list" do
        put :update,
          params: {id: phase.to_param, phase: valid_attributes},
          session: valid_session
        expect(response).to redirect_to tournament_phases_path(tournament)
      end
    end

    context "with invalid params" do
      let(:phase) { Phase.create! valid_attributes }

      it "returns a success response (i.e. to display the 'edit' template)" do
        put :update,
          params: {id: phase.to_param, phase: invalid_attributes},
          session: valid_session
        expect(response).not_to be_success
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:phase) { Phase.create! valid_attributes }

    it "destroys the requested phase" do
      expect {
        delete :destroy, params: {id: phase.to_param}, session: valid_session
      }.to change(Phase, :count).by(-1)
    end

    it "redirects to the phases list" do
      delete :destroy, params: {id: phase.to_param}, session: valid_session
      expect(response).to redirect_to tournament_phases_path(tournament)
    end
  end
end
