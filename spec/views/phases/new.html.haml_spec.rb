require 'rails_helper'

RSpec.describe "phases/new", type: :view do
  let(:tournament) { create(:tournament) }

  before(:each) do
    assign(:tournament, tournament)
    assign(:phase, Phase.new)
  end

  it "renders new phase form" do
    render

    assert_select "form[action=?][method=?]", tournament_phases_path(tournament), "post" do
    end
  end
end
