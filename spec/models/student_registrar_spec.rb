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
      expect(ClassAssignment.count).to eq 2
      expect(ClassAssignment.where(student_class: student.student_classes.first).count).to eq 2
      expect(student.student_classes.first.assignments.map(&:name)).to eq(Assignment.all.map(&:name))
    end

    it 'does not duplicate students already assigned to the class period' do
      students = FactoryGirl.create_list(:student, 3)
      class_period = FactoryGirl.create(:class_period, students: students)

      expect(class_period.students.count).to eq 3
      StudentRegistrar.new(class_period: class_period).enroll(students: students)
      expect(class_period.students.count).to eq 3
    end

    it 'does not create duplicate assignments for students previously enrolled' do
      student = FactoryGirl.create(:student)
      course = FactoryGirl.create(:course_with_units_and_assignments)
      class_period = FactoryGirl.create(:class_period, students: [student], course: course)

      expect(ClassAssignment.count).to eq 0
      registrar = StudentRegistrar.new class_period: class_period
      registrar.enroll(students: [student])
      expect(ClassAssignment.count).to eq 2
      registrar.enroll(students: [student])
      expect(ClassAssignment.count).to eq 2
    end

    it 'does not remove previous students when adding new students' do
      old_student = FactoryGirl.create(:student)
      new_student = FactoryGirl.create(:student)
      course = FactoryGirl.create(:course_with_units_and_assignments)
      class_period = FactoryGirl.create(:class_period, course: course)

      expect(class_period.students.count).to eq 0
      registrar = StudentRegistrar.new class_period: class_period
      registrar.enroll(students: [old_student])
      expect(class_period.students.count).to eq 1
      registrar.enroll(students: [new_student])
      expect(class_period.students.count).to eq 2
      expect(ClassAssignment.count).to eq 4
    end
  end

  #TODO lookup how to throw and expect exceptions
  #it 'does not save students in class period if ClassAssignment raise an exception' do
  #    new_student = FactoryGirl.create(:student)
  #    class_period = FactoryGirl.create(:class_period)
  #    expect(class_period).to receive(:course).and_throw('error!!')

  #    expect(StudentRegistrar.new(class_period: class_period).enroll(students: new_student)).to raise { 'error!!' }
  #    expect(class_period.students).to eq nil
  #end
end
