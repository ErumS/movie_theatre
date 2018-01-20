require 'as-duration'

FactoryGirl.define do
  factory :showtime do
    time_of_show Faker::Time.between(2.days.ago, Date.today, :all).strftime("%H:%M")
    association :movie, factory: :movie, strategy: :create
  end
end