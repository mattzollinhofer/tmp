class ClassAssignment < ActiveRecord::Base
  belongs_to :student_class
  belongs_to :assignment

  scope :all_points_for, -> (student_class, unit) do
    where(student_class: student_class, assignment: unit.assignments).map do |assignment|
      (assignment.notes_earned || 0) + (assignment.ixl_earned || 0) + (assignment.points_earned || 0) + (assignment.stars_earned || 0)
    end.sum
  end

  scope :points_for, -> (student_class, assignment) do
    find_by(student_class: student_class, assignment: assignment).points_earned
  end
end
