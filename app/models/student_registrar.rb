class StudentRegistrar
  attr_reader :class_period

  def initialize(class_period:)
    @class_period = class_period
  end

  def enroll(students: [])
    return if students.blank?
    students = ensure_all_students_included(Array(students))

    ActiveRecord::Base.transaction do
      class_period.students = students
      synchronize_assignments_for students
      class_period.save!
    end
  end

  private

  def synchronize_assignments_for students
    class_period.assignments.each do |assignment|
      students.each do |student|
        student_class = class_period.student_classes.find_by(student: student)
        next if assignment_exists_for_student_class? assignment, student_class
        ClassAssignment.create(assignment: assignment, student_class: student_class)
      end
    end
  end

  def assignment_exists_for_student_class? assignment, student_class
    ClassAssignment.where(assignment: assignment, student_class: student_class).present?
  end

  def ensure_all_students_included students
    (students + class_period.students).uniq
  end

end
