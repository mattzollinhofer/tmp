class ClassAssignment < ActiveRecord::Base
  belongs_to :student_class
  belongs_to :assignment

  before_save :update_completed_at if self.notes_earned_changed?

  delegate :due_at, :ixl_description, :ixl_url, :ixl_points_possible, :worksheet_points_possible, :name,
           :notes_points_possible, :possible_points, :possible_type_count, to: :assignment, allow_nil: true

  scope :all_points_for_unit, -> (student_class, unit) do
    where(student_class: student_class, assignment: unit.assignments).map do |class_assignment|
      class_assignment.all_points_earned
    end.sum
  end

  scope :all_points_for_assignment, -> (student_class, assignment) do
    where(student_class: student_class, assignment: assignment).map do |class_assignment|
      class_assignment.all_points_earned
    end.sum
  end

  scope :points_for, -> (student_class, assignment) do
    find_by(student_class: student_class, assignment: assignment).points_earned
  end

  def all_points_earned
    ((notes_earned || 0) + (ixl_earned || 0) + (points_earned || 0) + (stars_earned || 0))
  end

  def number_graded
    [self[:notes_earned], self[:ixl_earned], self[:points_earned], self[:stars_earned]].compact.size
  end

  def update_completed_at
    if notes_earned > 0
      self[:completed_at] = Date.today.strftime('%m/%d/%Y')
    else
      self[:completed_at] = nil
    end
  end

  def overdue?
    if completed_at.present? || due_at.blank? || Date.strptime(due_at, '%m/%d/%Y') > Date.today
      false
    else
      true
    end
  end
end
