class CoursesController < ApplicationController
  def new
    @course = Course.new
  end

  def create
    Course.create!(course_params.merge(teachers: [current_user]))
    redirect_to welcome_index_path
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end
end
