require 'rails_helper'

RSpec.describe "phases/index", type: :view do
  let(:tournament) { create(:tournament) }

  before(:each) do
    assign(:tournament, tournament)
    assign(:phases, [
      create(:phase, tournament: tournament),
      create(:phase)
    ])
  end

  it "renders a list of phases" do
    render
  end
end
