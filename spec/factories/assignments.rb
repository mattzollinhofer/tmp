FactoryGirl.define do
  factory :assignment do
    sequence(:name)    { |n| "Assignment Bar #{n}" }
    worksheet_points_possible 4
    star_points_possible 3
    notes_points_possible 2
    ixl_points_possible 1
    sequence(:order) { |n|  n }
  end
end
