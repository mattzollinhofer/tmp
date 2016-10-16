class StudentRegistrar
  attr_reader :class_period

  def initialize(class_period:)
    @class_period = class_period
  end

  def enroll(students: [])
    return if students.empty?

    ActiveRecord::Base.transaction do
      @class_period.students = students
      synchronize_assignments_for students
      @class_period.save!
    end
  end

  private

  def synchronize_assignments_for students
    #ClassPeriod.where()
  end

end
