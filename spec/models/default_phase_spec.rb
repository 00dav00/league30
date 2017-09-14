require 'rails_helper'

RSpec.describe DefaultPhase, type: :model do
  describe '.model_name' do
    subject { described_class.model_name }
    it { is_expected.to eq 'Phase' }
  end
end
