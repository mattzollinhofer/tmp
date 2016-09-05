FactoryGirl.define do
  factory :assignment do
    sequence(:name)    { |n| "Assignement Bar #{n}" }
    points_possible 4
    stars_possible 3
    sequence(:order) { |n| n }

    association :unit, strategy: :build
  end
end
