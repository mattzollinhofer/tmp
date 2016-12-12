FactoryGirl.define do
  factory :assignment do
    sequence(:name)    { |n| "Assignment Bar #{n}" }
    points_possible 4
    stars_possible 3
    sequence(:order) { |n|  n }
  end
end
