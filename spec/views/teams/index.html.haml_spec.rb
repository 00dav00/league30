require 'rails_helper'

RSpec.describe 'teams/index', type: :view do
  let(:teams) { create_list(:team, 2) }

  before(:each) do
    assign(:teams, teams) 
  end

  it 'renders a list of teams' do
    render
    assert_select 'tr>td', text: teams.first.short_name, count: 2
    assert_select 'tr>td', text: teams.first.name, count: 2
    assert_select 'tr>td', text: teams.first.full_name, count: 2
  end
end
