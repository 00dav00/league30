require 'rails_helper'

RSpec.describe "phases/index", type: :view do
  before(:each) do
    assign(:phases, [
      Phase.create!(),
      Phase.create!()
    ])
  end

  it "renders a list of phases" do
    render
  end
end
