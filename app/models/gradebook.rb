class Gradebook
  attr_reader :class_period, :unit

  delegate :students, to: :class_period

  def initialize(class_period, unit)
    @class_period = class_period
    @unit = unit
  end

  def assignments
    return [] if @unit.blank?

    @unit.assignments
  end

  def total_points_possible
    #TODO memoize this value?
    assignments.map do |assignment|
      assignment.notes_points_possible +
      assignment.ixl_points_possible +
      assignment.worksheet_points_possible +
      assignment.star_points_possible
    end.sum
  end

  def percentage_for(student)
    return 0 if total_points_possible == 0

    ((points_for(student).to_f / total_points_possible.to_f) * 100).round
  end

  def points_for(student)
    #TODO memoize this value?

    student_class = student.student_classes.find_by(class_period: class_period)
    ClassAssignment.all_points_for_unit(student_class, @unit)
  end

  def class_assignment_for(student, assignment)
    student_class = StudentClass.find_by(student: student, class_period: class_period)
    ClassAssignment.find_or_create_by(assignment: assignment, student_class: student_class)
  end

  def setup_complete?
    students.present? && assignments.present?
  end
end
