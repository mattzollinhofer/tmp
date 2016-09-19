module ClassPeriodHelper
  include CourseHelper

  def class_period_short_label(class_period)
    "#{class_period.course.name.capitalize} Period: #{class_period.period}"
  end

  def class_period_label(class_period)
    "#{class_period_short_label(class_period)} - #{taught_by_teachers(class_period)}"
  end

  def taught_by_teachers(class_period)
    "Taught by: #{class_period.teacher_names}"
  end

  def teacher_class_period(class_period)
    "#{course_link(class_period.course)} Period: #{class_period.period} - #{taught_by_teachers(class_period)}"
  end
end
