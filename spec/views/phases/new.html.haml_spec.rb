require 'rails_helper'

RSpec.describe "phases/new", type: :view do
  before(:each) do
    assign(:phase, Phase.new())
  end

  it "renders new phase form" do
    render

    assert_select "form[action=?][method=?]", phases_path, "post" do
    end
  end
end
