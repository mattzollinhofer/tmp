class WelcomeController < ApplicationController
  def index
    send :"welcome_#{current_user.type.downcase}"
  end

  def welcome_teacher
    @welcome = TeacherWelcome.new(current_user)
    render 'welcome/teacher'
  end

  def welcome_student
    student = current_user
    if student.class_periods.count == 1
      redirect_to playbook_path(class_period_id: student.class_periods.first.id,
                                unit_id: CurrentUnitSelector.new(student).select,
                                student_id: student.id)
    else
      @welcome = StudentWelcome.new student
      render 'welcome/student'
    end
  end

  def welcome_guest
    render 'welcome/guest'
  end
end
