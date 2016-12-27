class Registrar

  def enroll(class_period_id:, students: [])
    return if students.blank?
    return if class_period_id.blank?

    students = Student.where(id: students)
    class_period = ClassPeriod.find(class_period_id)

    students = ensure_all_students_included(Array(students), class_period)

    ActiveRecord::Base.transaction do
      class_period.students = students
      synchronize_assignments_for(students, class_period)
      class_period.save!
    end
  end

  def unenroll(class_period_id:, student_id:)
    return false if student_id.blank?
    return false if class_period_id.blank?

    student_class = StudentClass.find_by(class_period: class_period_id, student: student_id)
    student_class.destroy
  end

  private

  def synchronize_assignments_for(students, class_period)
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

  def ensure_all_students_included(students, class_period)
    (students + class_period.students).uniq
  end

end
