class Course < ActiveRecord::Base
  has_many :assignments
  has_many :student_courses
  has_many :students, through: :student_courses
  has_many :teacher_courses
  has_many :teachers, through: :teacher_courses

  validates :name, presence: true

  def to_s
    "#{name}, taught by #{teachers.map(&:first_name).join(', ')}"
  end
end
