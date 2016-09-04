FactoryGirl.define do
  factory :course do
    sequence(:name) { |n| "English 10#{n}" }
  end

  factory :course_with_units_and_assignments, parent: :course do
    after(:create) do |course|
      course.units = create(:unit_with_assignments)
      #association :units, factory: :unit_with_assignments, strategy: :build
    end
  end
end
