class TeacherWelcome
  attr_reader :teacher, :user

  def initialize(teacher)
    @teacher = teacher
  end

  def user
    teacher.user
  end

  def courses
    teacher.courses
  end
end
