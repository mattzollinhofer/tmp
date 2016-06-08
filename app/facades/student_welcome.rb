class StudentWelcome
  attr_reader :student

  def initialize(student)
    @student = student
  end

  def courses
    student.courses
  end
end
