require 'rails_helper'

describe Registrar do
  describe '#enroll' do
    it 'does nothing when no students are provided' do
      expect(ActiveRecord::Base).not_to receive :transaction
      Registrar.new.enroll(class_period_id: 2, students: nil)
    end

    it 'assigns new students to the class period' do
      new_student = FactoryBot.create(:student)
      students = FactoryBot.create_list(:student, 3)
      class_period = FactoryBot.create(:class_period, students: students)

      Registrar.new.enroll(class_period_id: class_period.id, students: (students << new_student))
      expect(class_period.reload.students).to include new_student
    end

    it 'creates assignments for new students' do
      student = FactoryBot.create(:student)
      course = FactoryBot.create(:course_with_units_and_assignments)
      class_period = FactoryBot.create(:class_period, students: [student], course: course)

      expect(ClassAssignment.count).to eq 0
      registrar = Registrar.new.enroll(class_period_id: class_period.id, students: [student])
      expect(ClassAssignment.count).to eq 2
      expect(ClassAssignment.where(student_class: student.student_classes.first).count).to eq 2
      expect(student.student_classes.first.assignments.map(&:name)).to eq(Assignment.all.map(&:name))
    end

    it 'does not duplicate students already assigned to the class period' do
      students = FactoryBot.create_list(:student, 3)
      class_period = FactoryBot.create(:class_period, students: students)

      expect(class_period.students.count).to eq 3
      Registrar.new.enroll(class_period_id: class_period.id, students: students)
      expect(class_period.reload.students.count).to eq 3
    end

    it 'does not create duplicate assignments for students previously enrolled' do
      student = FactoryBot.create(:student)
      course = FactoryBot.create(:course_with_units_and_assignments)
      class_period = FactoryBot.create(:class_period, students: [student], course: course)

      expect(ClassAssignment.count).to eq 0
      registrar = Registrar.new
      registrar.enroll(class_period_id: class_period.id, students: [student])
      expect(ClassAssignment.count).to eq 2
      registrar.enroll(class_period_id: class_period.id, students: [student])
      expect(ClassAssignment.count).to eq 2
    end

    it 'does not remove previous students when adding new students' do
      old_student = FactoryBot.create(:student)
      new_student = FactoryBot.create(:student)
      course = FactoryBot.create(:course_with_units_and_assignments)
      class_period = FactoryBot.create(:class_period, course: course)

      expect(class_period.students.count).to eq 0
      registrar = Registrar.new
      registrar.enroll(class_period_id: class_period.id, students: [old_student])
      expect(class_period.students.count).to eq 1
      registrar.enroll(class_period_id: class_period.id, students: [new_student])
      expect(class_period.students.count).to eq 2
      expect(ClassAssignment.count).to eq 4
    end
  end

  describe '#unenroll' do
    it 'destroys the student_class record associated with the student and class period' do
      student = FactoryBot.create(:student)
      class_period = FactoryBot.create(:class_period, students: [student])
      expect(StudentClass.count).to eq 1
      expect(Registrar.new.unenroll(class_period_id: class_period.id, student_id: student.id))
        .to be_an_instance_of(StudentClass)
      expect(StudentClass.count).to eq 0
    end
    it 'returns false when provided a blank student_id' do
      expect(Registrar.new.unenroll(class_period_id: nil, student_id: 3)).to eq false
    end
    it 'returns false when provided a blank class_period_id' do
      expect(Registrar.new.unenroll(class_period_id: 23, student_id: nil)).to eq false
    end
  end

  #TODO lookup how to throw and expect exceptions
  #it 'does not save students in class period if ClassAssignment raise an exception' do
  #    new_student = FactoryBot.create(:student)
  #    class_period = FactoryBot.create(:class_period)
  #    expect(class_period).to receive(:course).and_throw('error!!')

  #    expect(Registrar.new(class_period_id: class_period).enroll(students: new_student)).to raise { 'error!!' }
  #    expect(class_period.students).to eq nil
  #end
end
