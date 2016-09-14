module ClassPeriodHelper
  include CourseHelper
  def class_period_label(class_period)
    course_link(class_period.course) + " - Period: #{class_period.period} - Taught by: #{class_period.teachers.map(&:name).join(', ')}"
  end
end
