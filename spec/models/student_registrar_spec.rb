require 'rails_helper'

describe StudentRegistrar do
  describe '#enroll' do
    it 'does nothing when no students are provided' do
      expect(ActiveRecord::Base).not_to receive :transaction
      StudentRegistrar.new(class_period:nil).enroll(students: nil)
    end

    it 'assigns new students to the class period' do
      new_student = FactoryGirl.create(:student)
      students = FactoryGirl.create_list(:student, 3)
      class_period = FactoryGirl.create(:class_period, students: students)

      StudentRegistrar.new(class_period: class_period).enroll(students: (students << new_student))
      expect(class_period.students).to include new_student
    end

    it 'creates assignments for new students' do
      student = FactoryGirl.create(:student)
      course = FactoryGirl.create(:course_with_units_and_assignments)
      class_period = FactoryGirl.create(:class_period, students: [student], course: course)

      expect(ClassAssignment.count).to eq 0
      registrar = StudentRegistrar.new class_period: class_period
      registrar.enroll(students: [student])
      expect(ClassAssignment.where(student_class: student.student_classes.first).count).to eq 2
    end

    it 'does not create duplicate assignments for students previously enrolled' do
    end
  end
end
