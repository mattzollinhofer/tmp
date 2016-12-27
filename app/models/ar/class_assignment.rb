class ClassAssignment < ActiveRecord::Base
  belongs_to :student_class
  belongs_to :assignment

  scope :points_for, -> (student_class, assignment) do
    find_by(student_class: student_class, assignment: assignment).points_earned
  end
end
