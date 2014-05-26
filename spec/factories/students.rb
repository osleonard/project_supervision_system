FactoryGirl.define do
  factory :student do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    sequence(:matric_no, "001") { |n| "AUO/11/#{n}" }
    password "passw0rd"
    password_confirmation "passw0rd"
  end
end
