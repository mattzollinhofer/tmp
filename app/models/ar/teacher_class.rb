class TeacherClass < ActiveRecord::Base
  belongs_to :teacher
  validates :teacher, presence: true

  belongs_to :class_period
  validates :class_period, presence: true
end
