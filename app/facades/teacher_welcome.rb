class TeacherWelcome
  attr_reader :teacher

  def initialize(teacher)
    @teacher = teacher
  end

  def class_periods
    teacher.class_periods.includes(:course)
  end

  def manageable_units
    teacher.class_periods.map(&:units).flatten.uniq
  end

  def class_periods?
    teacher.class_periods.present?
  end
end
