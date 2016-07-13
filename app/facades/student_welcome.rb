class StudentWelcome
  attr_reader :student

  def initialize(student)
    @student = student
  end

  def courses
    student.class_periods.map &:course
  end
end
