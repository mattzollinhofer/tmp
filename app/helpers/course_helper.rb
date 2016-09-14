module CourseHelper
  def course_link(course)
    link_to course, course.name.capitalize
  end
end
