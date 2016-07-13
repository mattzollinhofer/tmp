class WelcomeController < ApplicationController
  def index
    @welcome = if current_user.class == Student
                 StudentWelcome.new current_user
               elsif current_user.class == Teacher
                 TeacherWelcome.new(current_user, Course.all)
               end

    render "welcome/#{current_user.type.downcase}"
  end
end
