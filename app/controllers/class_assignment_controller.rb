class ClassAssignmentController < ApplicationController
  def update
    class_assignment = ClassAssignment.find params[:id]
    if class_assignment.update_attributes(class_assignment_params)
      @student = class_assignment.student_class.student
      @total_points = ClassAssignment.all_points_for_unit(class_assignment.student_class, class_assignment.assignment.unit)
      flash[:success] = 'Updated assignment'
    else
      flash[:error] = 'Failed to update assignment'
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private

  def class_assignment_params
    params.require(:class_assignment).permit(:points_earned, :stars_earned, :notes_earned, :ixl_earned)
  end
end
