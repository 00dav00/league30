require 'rails_helper'

RSpec.describe "teams/new", type: :view do
  before(:each) do
    assign(:team, build(:team))
  end

  it "renders new team form" do
    render

    assert_select "form[action=?][method=?]", teams_path, "post" do

      assert_select "input[name=?]", "team[short_name]"

      assert_select "input[name=?]", "team[name]"

      assert_select "input[name=?]", "team[full_name]"

      assert_select "input[name=?]", "team[logo_image]"
    end
  end
end
