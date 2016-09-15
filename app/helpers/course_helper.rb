module CourseHelper
  def course_link(course)
    link_to course.name.capitalize, course_path(course)
  end
end
