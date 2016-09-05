FactoryGirl.define do
  factory :unit do
    sequence(:name)    { |n| "Unit Foo#{n}" }
    sequence(:order)    { |n| n }

    association :course, strategy: :build
  end

  factory :unit_with_assignments, parent: :unit do
    after(:stub) do |unit|
      unit.assignments = stub_list(:assignment, 2, unit: unit)
      unit.assignments.each { |a| a.unit_id = unit.id }
    end
    after(:build) do |unit|
      unit.assignments = build_list(:assignment, 2, unit: unit)
      unit.assignments.each { |a| a.unit_id = unit.id }
    end
    after(:create) do |unit|
      unit.assignments = create_list(:assignment, 2, unit: unit)
      unit.assignments.each { |a| a.unit_id = unit.id }
    end
  end
end
