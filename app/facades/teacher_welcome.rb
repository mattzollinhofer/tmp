class TeacherWelcome
  attr_reader :teacher

  def initialize(teacher)
    @teacher = teacher
  end

  def courses
    teacher.courses
  end
end
