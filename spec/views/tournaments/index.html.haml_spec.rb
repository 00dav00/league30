require 'rails_helper'

RSpec.describe "tournaments/index", type: :view do
  before(:each) do
    assign(:tournaments, [
      FactoryGirl.create(:tournament),
      FactoryGirl.create(:tournament, name: 'Winter tournament')
    ])
  end

  it "renders a list of tournaments" do
    render
  end
end
