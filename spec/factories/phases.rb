FactoryGirl.define do
  factory :phase do
    tournament
    name 'First Phase'
    position_in_tournament 1
    type :default
  end
end
