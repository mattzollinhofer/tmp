FactoryGirl.define do
  factory :class_period do
    sequence(:period)       { |n| n }
    association :course, strategy: :build

    after(:build) do |class_period|
      build_list(:teacher, 1, class_periods: [class_period])
    end
    after(:create) do |class_period|
      create_list(:teacher, 2, class_periods: [class_period])
    end
  end
end
