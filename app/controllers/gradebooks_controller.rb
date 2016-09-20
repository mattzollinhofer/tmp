class GradebooksController < ApplicationController
  def show
    @class_period = ClassPeriod.find(params[:id])
  end
end
