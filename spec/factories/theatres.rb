FactoryGirl.define do
  factory :theatre do
  	name Faker::Name.name
  	address Faker::Address.street_address
  	phone_no "6473928575"
  end
end