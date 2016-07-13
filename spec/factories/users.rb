FactoryGirl.define do
  factory :user do
    sequence(:first_name)         { |n| "User#{n}" }
    last_name 'Smith'
    sequence(:email)              { |n| "user#{n}@test.com" }
    sequence(:mobile_number)      { |n| "555-555-555#{n}" }
    password 'password'
    admin false

    factory :student, class: Student, parent: :user do
      nickname 'Hoffa'
      graduation_year { (Date.today).year }
    end

    factory :teacher, class: Teacher do
    end

    factory :admin, class: Teacher do
      admin true
    end
  end
end
