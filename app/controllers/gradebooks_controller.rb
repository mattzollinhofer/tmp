class GradebooksController < ApplicationController
  def show
    @gradebook = Gradebook.new(ClassPeriod.find(params[:id]), Unit.find(params[:unit_id]))
    @class_period = ClassPeriod.find(params[:id])
    update_teacher_current_view(@class_period, params[:unit_id])
  end

  private

  def update_teacher_current_view(class_period, unit_id)
    teacher = current_user
    current_settings = teacher.settings(:prefs).current || {}
    teacher.settings(:prefs).update_attributes(:current => (current_settings.merge!({"#{class_period.id}": unit_id})))
  end
end
