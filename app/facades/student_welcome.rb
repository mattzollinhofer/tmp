class StudentWelcome
  attr_reader :student, :user

  def initialize(student)
    @student = student
  end

  def user
    student.user
  end

  def courses
    student.courses
  end
end
