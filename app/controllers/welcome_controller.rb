class WelcomeController < ApplicationController
  def index
    send :"welcome_#{current_user.type.downcase}"
  end

  def welcome_teacher
    @welcome = TeacherWelcome.new(current_user)
    render 'welcome/teacher'
  end

  def welcome_student
    if current_user.class_periods.count == 1
      redirect_to playbook_path(class_period_id: current_user.class_periods.first.id,
                                unit_id: current_user.class_periods.first.course.units.first.id,
                                student_id: current_user.id)
    else
      @welcome = StudentWelcome.new current_user
      render 'welcome/student'
    end
  end

  def welcome_guest
    render 'welcome/guest'
  end
end
