FactoryGirl.define do
  factory :tournament_contestant, class: 'Tournament::Contestant' do
    tournament
    team
  end
end
