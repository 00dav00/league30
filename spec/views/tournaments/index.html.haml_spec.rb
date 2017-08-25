require 'rails_helper'

RSpec.describe "tournaments/index", type: :view do
  before(:each) do
    assign(:tournaments, [
      Tournament.create!(),
      Tournament.create!()
    ])
  end

  it "renders a list of tournaments" do
    render
  end
end
