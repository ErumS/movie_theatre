FactoryGirl.define do
  factory :booking do
    booking_type Faker::Music.key
    no_of_bookings Faker::Number.between(1, 6)
  end
end