FactoryGirl.define do
  factory :assignment do
    points_earned 1
    points_possible 1
    order 1
    due_at "2016-04-01 08:08:13"
    completed_at "2016-04-01 08:08:13"
    time_zone_id "MyString"
  end
end
