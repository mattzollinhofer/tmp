class PlaybooksController < ApplicationController
  def show
    student = Student.find(params[:student_id])
    student.settings(:prefs).update_attributes(:current => params[:unit_id])

    @playbook = Playbook.new(unit: Unit.find(params[:unit_id]),
                             student: student,
                             class_period: ClassPeriod.find(params[:class_period_id]))
  end
end
