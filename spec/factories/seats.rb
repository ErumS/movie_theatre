FactoryGirl.define do
  factory :seat do
    type_of_seat Faker::Music.key
  end
end