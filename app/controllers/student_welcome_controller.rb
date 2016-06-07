class StudentWelcomeController < ApplicationController
  def index
    @student_welcome = StudentWelcome.new Student.find_by(user: current_user)
  end
end
