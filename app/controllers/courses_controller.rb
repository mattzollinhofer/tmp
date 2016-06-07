class CoursesController < ApplicationController
  def new
    @course = Course.new
  end

  def create
    teacher = Teacher.find_or_create_by(user: current_user)
    Course.create!(course_params.merge(teachers: [teacher]))
    redirect_to teacher_welcome_index_path
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end
end
