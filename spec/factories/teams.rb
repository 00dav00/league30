FactoryGirl.define do
  factory :team do
    short_name 'Boca'
    name 'Boca Juniors'
    full_name 'Club Atletico Boca Juniors'
    logo_image File.open(Rails.root.join('spec/fixtures/images/team_square.jpg'))
  end
end
