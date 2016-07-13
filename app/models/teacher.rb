class Teacher < User
  has_many :teacher_classes
  has_many :class_periods, through: :teacher_classes
end
