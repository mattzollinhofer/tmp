class StudentClass < ActiveRecord::Base
  belongs_to :student
  validates :student, presence: true

  belongs_to :class_period
  validates :class_period, presence: true

  has_many :class_assignments, dependent: :destroy

  def assignments
    class_assignments.map(&:assignment)
  end
end
