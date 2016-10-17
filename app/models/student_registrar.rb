class StudentRegistrar
  attr_reader :class_period

  def initialize(class_period:)
    @class_period = class_period
  end

  def enroll(students: [])
    return if students.blank?

    ActiveRecord::Base.transaction do
      @class_period.students = students
      synchronize_assignments_for students
      @class_period.save!
    end
  end

  private

  def synchronize_assignments_for students
    @class_period.course.assignments.each do |assignment|
      students.each do |student|
        ClassAssignment.create(assignment: assignment,
                               student_class: @class_period.student_classes.where(student: student).first )
      end
    end
  end

end
