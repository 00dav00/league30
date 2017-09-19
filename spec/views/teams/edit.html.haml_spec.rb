require 'rails_helper'

RSpec.describe "teams/edit", type: :view do
  before(:each) do
    @team = assign(:team, create(:team))
  end

  it "renders the edit team form" do
    render

    assert_select "form[action=?][method=?]", team_path(@team), "post" do

      assert_select "input[name=?]", "team[short_name]"

      assert_select "input[name=?]", "team[name]"

      assert_select "input[name=?]", "team[full_name]"

      assert_select "input[name=?]", "team[logo_image]"
    end
  end
end
