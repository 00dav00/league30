require 'rails_helper'

RSpec.describe Phase, type: :model do
  it { is_expected.to validate_inclusion_of(:type).in_array(Phase::TYPES) }
end
