class TeacherWelcomeController < ApplicationController
  def index
    @teacher_welcome = TeacherWelcome.new Teacher.find_by(user: current_user)
  end
end
