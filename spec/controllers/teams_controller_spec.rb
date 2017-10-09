require 'rails_helper'

RSpec.describe TeamsController, type: :controller do
  let(:valid_attributes) {
    attributes_for(:team)
      .merge(logo_image: fixture_file_upload('spec/fixtures/images/team_square.jpg', 'image/jpg'))
  }
  let(:invalid_attributes) { { name: '' } }

  let(:valid_session) { {} }

  describe 'GET #index' do
    it 'returns a success response' do
      get :index, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #new' do
    it 'returns a success response' do
      get :new, params: {}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'GET #edit' do
    let(:team) { create(:team) }
    it 'returns a success response' do
      get :edit, params: {id: team.id}, session: valid_session
      expect(response).to be_success
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new Team' do
        expect {
          post :create, params: {team: valid_attributes}, session: valid_session
        }.to change(Team, :count).by(1)
      end

      it 'redirects to the created team' do
        post :create, params: {team: valid_attributes}, session: valid_session
        expect(response).to redirect_to teams_path
      end
    end

    context 'with invalid params' do
      it 'creates a new Team' do
        expect {
          post :create, params: {team: invalid_attributes}, session: valid_session
        }.not_to change(Team, :count)
      end

      it 'returns a success response (i.e. to display the "new" template)' do
        post :create, params: {team: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'PUT #update' do
    let!(:team) { create(:team) }

    context 'with valid params' do
      let(:new_attributes) { {name: 'New Team'} }

      it 'updates the requested team' do
        put :update, params: {id: team.id, team: new_attributes}, session: valid_session
        team.reload
        expect(team.name).to eq new_attributes[:name]
      end

      it 'redirects to the team' do
        put :update, params: {id: team.id, team: new_attributes}, session: valid_session
        expect(response).to redirect_to teams_path
      end
    end

    context 'with invalid params' do
      it 'returns a success response (i.e. to display the "edit" template)' do
        put :update, params: {id: team.id, team: invalid_attributes}, session: valid_session
        expect(response).to be_success
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:team) { create(:team) }

    it 'destroys the requested team' do
      expect {
        delete :destroy, params: {id: team.to_param}, session: valid_session
      }.to change(Team, :count).by(-1)
    end

    it 'redirects to the teams list' do
      delete :destroy, params: {id: team.to_param}, session: valid_session
      expect(response).to redirect_to teams_path
    end
  end
end
