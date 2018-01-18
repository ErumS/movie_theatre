FactoryGirl.define do
  factory :viewer do
    name Faker::Name.name
    phone_no Faker::PhoneNumber.cell_phone
    mode_of_payment Faker::Name.name
  end
end