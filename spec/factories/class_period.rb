FactoryGirl.define do
  factory :class_period do
    sequence(:period)       { |n| n }
    association :course, strategy: :build

    factory :class_period_with_teachers, parent: :class_period do
      after(:stub) do |class_period|
        class_period.teachers = build_list(:teacher, 2, class_periods: [class_period])
      end
      after(:create) do |class_period|
        create_list(:teacher, 2, class_periods: [class_period])
      end
    end

    factory :class_period_with_students, parent: :class_period do
      after(:stub) do |class_period|
        class_period.students = build_list(:student, 4, class_periods: [class_period])
      end
      after(:create) do |class_period|
        create_list(:student, 4, class_periods: [class_period])
      end
    end
  end
end
