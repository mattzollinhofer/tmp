class GradebooksController < ApplicationController
  def show
    @gradebook = Gradebook.new(ClassPeriod.find(params[:id]), Unit.find(params[:unit_id]))
    @class_period = ClassPeriod.find(params[:id])
  end
end
