FactoryGirl.define do
  factory :course do
    sequence(:name) { |n| "Math 10#{n}" }
  end

  factory :course_with_units_and_assignments, parent: :course do
    after(:build) do |course|
      course.units = [build(:unit_with_assignments)]
      course.units.each { |unit| unit.course_id = course.id }
    end
    after(:create) do |course|
      course.units = [create(:unit_with_assignments)]
      course.units.each { |unit| unit.course_id = course.id }
    end
  end
end
