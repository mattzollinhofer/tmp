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

  def current_unit(class_period: default_class_period)
    CurrentUnitSelector.new(teacher).select(class_period: class_period)
  end

  private

  def default_class_period
    teacher.class_periods.first
  end
end
