class StudentWelcomeController < ApplicationController
  def index
    @student_welcome = StudentWelcome.new Student.find_by(user: current_user)
    render 'courses/index'
  end
end
