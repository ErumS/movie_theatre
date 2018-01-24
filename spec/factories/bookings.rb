FactoryGirl.define do
  factory :booking do
    booking_category Faker::Music.key
    no_of_bookings Faker::Number.between(1, 6)
    association :movie, factory: :movie, strategy: :create
    association :viewer, factory: :viewer, strategy: :create
  end
end
