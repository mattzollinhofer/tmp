class GradebooksController < ApplicationController
  def show
    @gradebook = Gradebook.new(ClassPeriod.find(params[:id]))
    @class_period = ClassPeriod.find(params[:id])
  end
end
