class AssignmentsController < ApplicationController
  def new
    @unit = Unit.find params[:unit_id]
    @assignment = Assignment.new unit: @unit
  end

  def create
    @assignment = Assignment.create!(assignment_params)
    redirect_to unit_path @assignment.unit
  end

  private

  def assignment_params
    params.require(:assignment).permit(:name, :order, :unit_id)
  end
end
