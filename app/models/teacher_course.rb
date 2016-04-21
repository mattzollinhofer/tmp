class TeacherCourse < ActiveRecord::Base
  belongs_to :teacher
  belongs_to :course

  validates :teacher, presence: true
  validates :course, presence: true
end
