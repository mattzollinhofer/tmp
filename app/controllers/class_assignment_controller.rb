class ClassAssignmentController < ApplicationController
  def update
    @class_assignment = ClassAssignment.find params[:id]
    if @class_assignment.update_attributes(class_assignment_params)
      flash[:success] = 'Updated assignment'
    else
      flash[:error] = 'Failed to update assignment'
    end
    redirect_to :back
  end

  private

  def class_assignment_params
    params.require(:class_assignment).permit(:points_earned, :stars_earned)
  end
end
