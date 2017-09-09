FactoryGirl.define do
  factory :phase do
    tournament
    name 'First Phase'
    position_in_tournament 1
    type 'DefaultPhase'
  end

  factory :default_phase, class: DefaultPhase, parent: :phase do
    type 'DefaultPhase'
  end
end
