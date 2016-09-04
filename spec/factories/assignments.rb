FactoryGirl.define do
  factory :assignment do
    points_earned 86
    points_possible 100
    sequence(:order) { |n| n }

    association :unit, strategy: :build
  end
end
