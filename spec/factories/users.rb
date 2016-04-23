FactoryGirl.define do
  factory :user do
    sequence(:first_name)         { |n| "User#{n}" }
    last_name 'Smith'
    sequence(:email_address)      { |n| "user#{n}@test.com" }
    sequence(:mobile_number)      { |n| "555-555-555#{n}" }
  end
end
