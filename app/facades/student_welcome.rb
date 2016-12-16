class StudentWelcome
  attr_reader :student

  def initialize(student)
    @student = student
  end

  def class_periods
    student.student_classes.map(&:class_period)
  end
end
