FactoryGirl.define do
  factory :auditorium do
    screen_size Faker::Demographic.height
    no_of_seats Faker::Number.between(1, 200)
    association :theatre, factory: :theatre, strategy: :create
    association :movie, factory: :movie, strategy: :create
  end
end
