class TeacherWelcome
  attr_reader :teacher

  def initialize(teacher)
    @teacher = teacher
  end

  def manageable_units
    teacher.class_periods.map(&:units).flatten
  end
end
