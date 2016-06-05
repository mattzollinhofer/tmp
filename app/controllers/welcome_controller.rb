class WelcomeController < ApplicationController
  def index
    if Student.find_by(user: current_user)
      @student_welcome = StudentWelcome.new Student.find_by(user: current_user)
      render 'student_welcome'
    elsif Teacher.find_by(user: current_user)
      @teacher_welcome = TeacherWelcome.new Teacher.find_by(user: current_user)
      render 'teacher_welcome'
    end
  end
end
