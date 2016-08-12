FactoryGirl.define do
  factory :unit do
    sequence(:name)    { |n| "Unit Foo#{n}" }
  end
end
