require 'rails_helper'

RSpec.describe "tournaments/show", type: :view do
  before(:each) do
    @tournament = assign(:tournament, Tournament.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
