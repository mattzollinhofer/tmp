FactoryGirl.define do
  factory :unit do
    sequence(:name)    { |n| "Unit Foo#{n}" }
    sequence(:order)    { |n| n }

    association :course, strategy: :build
  end
end
