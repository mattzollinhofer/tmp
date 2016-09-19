class ClassPeriod < ActiveRecord::Base
  belongs_to :course, inverse_of: :class_periods

  has_many   :teacher_classes
  has_many   :teachers, -> { order(:last_name) }, through: :teacher_classes

  has_many   :student_classes
  has_many   :students, through: :student_classes

  def teachers
    super.presence || [NullTeacher.new]
  end

  def teacher_names
    teachers.map(&:name).sort.to_sentence
  end
end
