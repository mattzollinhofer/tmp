class ClassPeriod < ActiveRecord::Base
  belongs_to :course, inverse_of: :class_periods

  has_many   :teacher_classes
  has_many   :teachers, through: :teacher_classes

  has_many   :student_classes
  has_many   :students, through: :student_classes
end
