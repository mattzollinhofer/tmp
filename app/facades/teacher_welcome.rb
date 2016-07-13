class TeacherWelcome
  attr_reader :teacher, :courses

  def initialize(teacher, courses)
    @teacher = teacher
    @courses = courses
  end
end
