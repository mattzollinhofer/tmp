class Gradebook
  attr_reader :class_period

  delegate :assignments, :students, to: :class_period

  def initialize(class_period)
    @class_period = class_period
  end

  def total_points_possible
    assignments.map do |assignment|
      assignment.notes_points_possible +
      assignment.ixl_points_possible +
      assignment.worksheet_points_possible +
      assignment.star_points_possible
    end.sum
  end

  def total_points_for(student)
    student_class = student.student_classes.find_by(class_period: class_period)
    ClassAssignment.all_points_for(student_class)
  end

  def class_assignment_for(student, assignment)
    student_class = StudentClass.find_by(student: student, class_period: class_period)
    ClassAssignment.find_or_create_by(assignment: assignment, student_class: student_class)
  end

  def points_for(student: nil, assignment: nil)
    student_class = StudentClass.for(student, class_period)
    ClassAssignment.points_for(student_class, assignment)
  end
end
