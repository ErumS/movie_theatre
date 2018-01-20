FactoryGirl.define do
  factory :seat do
    type_of_seat Faker::Music.key
    association :theatre, factory: :theatre, strategy: :create
    association :viewer, factory: :viewer, strategy: :create
    association :auditorium, factory: :auditorium, strategy: :create
  end
end