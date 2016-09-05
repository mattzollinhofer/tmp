FactoryGirl.define do
  factory :course do
    sequence(:name) { |n| "Math 10#{n}" }
  end

  factory :course_with_units_and_assignments, parent: :course do
    after(:stub) do |course|
      course.units = [stub(:unit_with_assignments)]
    end
    after(:build) do |course|
      course.units = [build(:unit_with_assignments)]
    end
    after(:create) do |course|
      course.units = [create(:unit_with_assignments)]
    end
  end
end
