class StudentWelcome
  attr_reader :student

  def initialize(student)
    @student = student
  end

  def class_periods
    student.student_classes.map(&:class_period)
  end

  def current_unit(class_period: default_class_period)
    CurrentUnitSelector.new(student).select(class_period: class_period)
  end

  private

  def default_class_period
    student.class_periods.first
  end
end
