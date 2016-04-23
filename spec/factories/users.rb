FactoryGirl.define do
  factory :user do
    sequence(:first_name)         { |n| "Matt#{n}" }
    last_name 'Zollinhofer'
    sequence(:email_address)      { |n| "matt#{n}@test.com" }
    sequence(:mobile_number)      { |n| "555-555-555#{n}" }
  end
end
