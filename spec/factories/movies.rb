FactoryGirl.define do
  factory :movie do
    name Faker::Name.name
    rating Faker::Number.between(1, 5)
    cast Faker::Name.name_with_middle
    duration Faker::Number.between(1, 4)
  end
end