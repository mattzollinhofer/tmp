class Playbook
  attr_reader :class_period, :unit, :student, :student_class

  def initialize(class_period: class_period, unit: unit, student: student)
    @class_period = class_period
    @unit = unit
    @student = student
    @student_class = student.student_classes.find_by(class_period: class_period)
  end

  def class_assignments
    return @class_assignments if @class_assignments.present?

    @class_assignments = []
    unit.assignments.each do |assignment|
      @class_assignments << ClassAssignment.find_or_create_by(assignment: assignment, student_class: student_class)
    end

    @class_assignments
  end

  def overdue_status(class_assignment)
    AssignmentStatus.new(class_assignment).overdue_status
  end

  def assignment_status(class_assignment)
    AssignmentStatus.new(class_assignment).status
  end

  def battery_level(class_assignment)
    AssignmentStatus.new(class_assignment).battery_level
  end
end
