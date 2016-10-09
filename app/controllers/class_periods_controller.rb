class ClassPeriodsController < ApplicationController
  def index
    @class_periods = ClassPeriod.all
  end

  def show
    @class_period = ClassPeriod.find(params[:id])
  end

  def new
    #@course = Course.find params[:course_id]
    @class_period = ClassPeriod.new
  end

  def create
    @class_periods = ClassPeriod.create!(class_period_params)
    redirect_to class_periods_path
  end

  def edit
    @class_period = ClassPeriod.find(params[:id])
  end

  def update
    @class_period = ClassPeriod.find(params[:id])
    if @class_period.update_attributes(class_period_params)
      redirect_to class_periods_path
    else
      render :edit
    end
  end

  def destroy
    @class_period = ClassPeriod.find(params[:id])
    @class_period.destroy
    redirect_to class_periods_path
  end

  def manage_students
    @class_period = ClassPeriod.find(params[:id])
  end

  def update_students
    registrar = StudentRegistrar.new(class_period: ClassPeriod.find(params[:id]))
    registrar.enroll(students: Student.where(student_id: class_period_params[:student_ids]))
    redirect_to manage_students_class_period_path
  end

  private

  def class_period_params
    params.require(:class_period).permit(:period, :course_id, student_ids: [], teacher_ids: [])
  end

end
