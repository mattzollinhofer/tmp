class PlaybooksController < ApplicationController
  def show
    @student = Student.find(params[:student_id])
    @class_period = ClassPeriod.find(params[:class_period_id])
  end
end
