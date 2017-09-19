require 'rails_helper'

RSpec.describe TeamLogoUploader, carrierewave: true do
  describe '#extension_white_list' do
    subject { described_class.new.extension_whitelist }
    it { is_expected.to include('jpg') }
    it { is_expected.to include('jpeg') }
    it { is_expected.to include('png') }
  end
end
