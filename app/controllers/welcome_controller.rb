class WelcomeController < ApplicationController
  def index
    if Student.find_by(user: current_user)
      redirect_to route_helpers.welcome_path
    elsif Teacher.find_by(user: current_user)
      redirect_to route_helpers.teacher_welcome_index_path
    end
  end
end
