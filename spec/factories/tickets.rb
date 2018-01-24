FactoryGirl.define do
  factory :ticket do
    movie_date Faker::Date.between(7.days.ago, Date.today)
    purchase_date Faker::Date.between(9.days.ago, Date.today)
    price Faker::Number.positive
    association :showtime, factory: :showtime, strategy: :create
    association :viewer, factory: :viewer, strategy: :create
    association :booking, factory: :booking, strategy: :create
  end
end
