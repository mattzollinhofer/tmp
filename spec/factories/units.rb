FactoryGirl.define do
  factory :unit do
    sequence(:name)    { |n| "Unit Foo#{n}" }
    sequence(:order)    { |n| n }

    association :course, strategy: :build
  end

  factory :unit_with_assignments, parent: :unit do
    after(:create) do |unit|
      unit.assignments = create_list(:assignment, 2, unit: unit)
    end
  end
end
