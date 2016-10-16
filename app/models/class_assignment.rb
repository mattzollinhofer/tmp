class ClassAssignment < ActiveRecord::Base
  belongs_to :student_class
  belongs_to :assignment
end
