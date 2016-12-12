class UnitsController < ApplicationController
  def index
    @units = Unit.all.order(:order)
  end

  def show
    @unit = Unit.find(params[:id])
  end

  def new
    @course = Course.find params[:course_id]
    @unit = Unit.new course: @course
  end

  def create
    @unit = Unit.create!(unit_params)
    redirect_to course_path @unit.course
  end

  def edit
    @unit = Unit.find(params[:id])
  end

  def update
    @unit = Unit.find(params[:id])
    if @unit.update_attributes(unit_params)
      redirect_to course_path @unit.course
    else
      render :edit
    end
  end

  def destroy
    @unit = Unit.find(params[:id])
    @unit.destroy
    redirect_to course_path @unit.course
  end

  private

  def unit_params
    params.require(:unit)
          .permit(:name, :order, :course_id)
  end

end
