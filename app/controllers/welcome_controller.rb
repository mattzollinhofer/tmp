class WelcomeController < ApplicationController
  def index
    send :"welcome_#{current_user.type.downcase}"
  end

  def welcome_teacher
    @welcome = TeacherWelcome.new(current_user, Course.all)
    render 'welcome/teacher'
  end

  def welcome_student
    @welcome = StudentWelcome.new current_user
    render 'welcome/student'
  end
end
