FactoryGirl.define do
  factory :teacher do
    association :user, strategy: :build
  end
end
