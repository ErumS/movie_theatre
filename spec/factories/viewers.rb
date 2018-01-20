FactoryGirl.define do
  factory :viewer do
    name Faker::Name.name
    phone_no "65747543983"
    mode_of_payment Faker::Name.name
    association :theatre, factory: :theatre, strategy: :create
    association :movie, factory: :movie, strategy: :create
  end
end