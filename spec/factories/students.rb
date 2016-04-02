FactoryGirl.define do
  factory :student do
    nickname 'Hoffa'
    graduation_year { (Date.today).year }
  end
end
