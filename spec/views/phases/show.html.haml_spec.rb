require 'rails_helper'

RSpec.describe "phases/show", type: :view do
  before(:each) do
    @phase = assign(:phase, Phase.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
