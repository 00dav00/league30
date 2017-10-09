FactoryGirl.define do
  factory :contestant, class: 'Tournament::Contestant' do
    tournament
    team
  end
end
