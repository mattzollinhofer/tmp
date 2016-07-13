FactoryGirl.define do
  factory :class_period do
    #association :teacher_classes, strategy: :build
    #association :student_classes, strategy: :build
    association :teachers, strategy: :build
    association :course, strategy: :build
  end
end
