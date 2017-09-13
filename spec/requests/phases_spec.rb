require 'rails_helper'

RSpec.describe "Phases", type: :request do
  describe "GET /phases" do
    let(:tournament) { create(:tournament) }

    it "works! (now write some real specs)" do
      get tournament_phases_path(tournament)
      expect(response).to have_http_status(200)
    end
  end
end
