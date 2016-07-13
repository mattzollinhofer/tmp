class StudentClass < ActiveRecord::Base
  belongs_to :student
  validates :student, presence: true

  belongs_to :class_period
  validates :class_period, presence: true
end
