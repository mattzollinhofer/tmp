class WelcomeController < ApplicationController
  def index
    if Student.find_by(user: current_user)
      redirect_to student_welcome_index_path
    elsif Teacher.find_by(user: current_user)
      redirect_to teacher_welcome_index_path
    end
  end
end
