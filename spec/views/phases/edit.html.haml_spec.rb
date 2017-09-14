require 'rails_helper'

RSpec.describe "phases/edit", type: :view do
  before(:each) do
    @phase = assign(:phase, create(:phase))
  end

  it "renders the edit phase form" do
    render

    assert_select "form[action=?][method=?]", phase_path(@phase), "post" do
    end
  end
end
