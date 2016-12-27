FactoryGirl.define do
  factory :class_period do
    sequence(:period)       { |n| n }
    association :course, strategy: :build

    trait :with_curriculum do
      after(:stub) do |class_period|
        course = build(:course)
        unit = build(:unit, course: course)
        assignments = build_list(:assignment, 2, unit: unit)
        class_period.course = course
      end
      after(:create) do |class_period|
        course = create(:course)
        unit = create(:unit, course: course)
        assignments = create_list(:assignment, 2, unit: unit)
        class_period.course = course
      end
    end

    trait :with_teachers do
      after(:stub) do |class_period|
        class_period.teachers = build_list(:teacher, 2, class_periods: [class_period])
      end
      after(:create) do |class_period|
        create_list(:teacher, 2, class_periods: [class_period])
      end
    end

    trait :with_students do
      after(:stub) do |class_period|
        class_period.students = build_list(:student, 4)
      end
      after(:create) do |class_period|
        create_list(:student, 4, class_periods: [class_period])
      end
    end
  end
end
