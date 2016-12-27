require 'spec_helper'

describe Gradebook do
  it 'has a class_period' do
    class_period = ClassPeriod.new()
    expect(Gradebook.new(class_period)).to respond_to :class_period
  end

  it 'has the assignments in this class' do
    class_period = FactoryGirl.create(:class_period, :with_curriculum)
    expect(Gradebook.new(class_period).assignments.count).to eq 2
  end

  it 'has the students in this class' do
    class_period = FactoryGirl.build_stubbed(:class_period, :with_students)
    expect(Gradebook.new(class_period).students.count).to eq 4
  end

  it 'retrieves the points earned for a student assignment' do
    class_period = FactoryGirl.create(:class_period, :with_curriculum)
    student = FactoryGirl.create(:student)
    class_period.students = [student]

    student_class = StudentClass.first
    assignment = Assignment.first
    ClassAssignment.create(student_class: student_class, assignment: assignment, points_earned: 4)

    expect(Gradebook.new(class_period).points_for(student: student, assignment: assignment)).to eq 4
  end

  it "has each student's assignment records for this class"
  it 'creates any missing assignments for a student in this class'

end
