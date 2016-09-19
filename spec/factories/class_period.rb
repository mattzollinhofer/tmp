FactoryGirl.define do
  factory :class_period do
    sequence(:period)       { |n| n }
    association :course, strategy: :build

    after(:stub) do |class_period|
      class_period.teachers = build_list(:teacher, 2, class_periods: [class_period])
    end
    after(:create) do |class_period|
      create_list(:teacher, 2, class_periods: [class_period])
    end
  end
end
