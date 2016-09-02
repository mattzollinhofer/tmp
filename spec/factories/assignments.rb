FactoryGirl.define do
  factory :assignment do
    points_earned 86
    points_possible 100
    sequence(:order) { |n| n }
    due_at '2016-04-11 08:08:13'
    completed_at '2016-04-01 08:08:13'
    time_zone_id 'EST'

    association :unit, strategy: :build
  end
end
