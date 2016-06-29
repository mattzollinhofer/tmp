class CoursesController < ApplicationController
  def new
    @course = Course.new
  end

  def create
    Course.create!(course_params.merge(teachers: [current_user]))
    redirect_to welcome_index_path
  end

  def edit
    @course = Course.find(params[:id])
    render :edit
  end

  def update
    @course = Course.find(params[:id])
    if @course.update_attributes(course_params)
      redirect_to welcome_index_path
    else
      render :edit
    end
  end

  private

  def course_params
    params.require(:course).permit(:name)
  end
end
