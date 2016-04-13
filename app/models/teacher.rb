class Teacher < ActiveRecord::Base
  belongs_to :user
  has_many :teacher_courses
  has_many :courses, through: :teacher_courses
  has_many :students, through: :courses
end
