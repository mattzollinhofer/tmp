FactoryGirl.define do
  factory :course do
    sequence(:name) { |n| "English 10#{n}" }
  end
end
