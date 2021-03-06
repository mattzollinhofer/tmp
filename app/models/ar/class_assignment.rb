class ClassAssignment < ApplicationRecord
  belongs_to :student_class
  belongs_to :assignment

  before_save :update_completed_at

  delegate :due_at, :ixl_description, :ixl_url, :ixl_points_possible, :worksheet_points_possible, :name, :notes_points_possible,
           :star_points_possible, :possible_points, :possible_type_count, to: :assignment, allow_nil: true

  scope :all_points_for_unit, -> (student_class, unit) do
    where(student_class: student_class, assignment: unit.assignments).map do |class_assignment|
      class_assignment.all_points_earned
    end.sum
  end

  scope :points_for, -> (student_class, assignment) do
    find_by(student_class: student_class, assignment: assignment).points_earned
  end

  def all_points_earned
    (notes_earned || 0) + (ixl_earned || 0) + (points_earned || 0)
  end

  def number_graded
    [self[:notes_earned], self[:ixl_earned], self[:points_earned], self[:stars_earned]].compact.size
  end

  def update_completed_at
    if notes_earned_changed?
      if notes_earned > 0
        self[:completed_at] = Date.today
      else
        self[:completed_at] = nil
      end
    end
  end

  def overdue?
    return false if completed_at.present?
    return false if due_at.blank?
    return false if Date.strptime(due_at, '%m/%d/%Y') >= Date.today

    return true
  end
end
