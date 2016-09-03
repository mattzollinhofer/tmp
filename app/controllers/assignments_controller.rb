class AssignmentsController < ApplicationController
  def new
    @unit = Unit.find params[:unit_id]
    @assignment = Assignment.new unit: @unit
  end

  def create
    @assignment = Assignment.create!(assignment_params)
    redirect_to unit_path @assignment.unit
  end

  def edit
    @assignment = Assignment.find params[:id]
  end

  def update
    @assignment = Assignment.find(params[:id])
    if @assignment.update_attributes(assignment_params)
      redirect_to unit_path @assignment.unit
    else
      render :edit
    end
  end

  def destroy
    @assignment = Assignment.find(params[:id])
    @assignment.destroy
    redirect_to unit_path @assignment.unit
  end

  private

  def assignment_params
    params.require(:assignment)
          .permit(:name, :points_possible, :stars_possible, :order, :unit_id)
  end
end
