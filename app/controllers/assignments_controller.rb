class AssignmentsController < ApplicationController
  def new
    @unit = Unit.find params[:unit_id]
    @assignment = Assignment.new unit: @unit
  end

  def create
    @assignment = Assignment.create!(assignment_params)

    @assignment.class_periods.each do |class_period|
      class_period.student_classes.each do |student_class|
        ClassAssignment.create!(assignment: @assignment, student_class: student_class)
      end
    end
    redirect_to unit_path @assignment.unit
  end

  def edit
    @assignment = Assignment.find params[:id]
    @unit = @assignment.unit
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
          .permit(:name, :worksheet_points_possible, :star_points_possible, :ixl_points_possible,
                  :notes_points_possible, :ixl_description, :ixl_url, :order, :unit_id, :due_at)
  end
end
