class Course < ActiveRecord::Base
  has_many :student_courses
  has_many :students, through: :student_courses
  has_many :teacher_courses
  has_many :teachers, through: :teacher_courses
end
