FactoryGirl.define do
  factory :phase do
    tournament
    name 'First Phase'
    sequence(:position_in_tournament)
    type 'DefaultPhase'
  end

  factory :default_phase, class: DefaultPhase, parent: :phase do
    type 'DefaultPhase'
  end

  factory :cumulative_phase, class: CumulativePhase, parent: :phase do
    type 'CumulativePhase'
  end

  factory :single_elimination_phase, class: SingleEliminationPhase, parent: :phase do
    type 'SingleEliminationPhase'
  end
end
