require 'rails_helper'

RSpec.describe TeamLogoUploader, carrierewave: true do
  include CarrierWave::Test::Matchers

  describe '#extension_white_list' do
    subject { described_class.new.extension_whitelist }
    it { is_expected.to include('jpg') }
    it { is_expected.to include('jpeg') }
    it { is_expected.to include('png') }
  end

  context 'thumb version' do
    let(:user) { double('user', id: 1, class: 'user') }
    let(:uploader) { described_class.new(user, :avatar) }

    before { described_class.enable_processing = true }
    after { described_class.enable_processing = false }

    it "scales down the image to be 200 x 200 px" do
      File.open('spec/fixtures/images/team_square.jpg') { |f| uploader.store!(f) }
      expect(uploader.thumb).to have_dimensions(200, 200)
    end
  end
end
