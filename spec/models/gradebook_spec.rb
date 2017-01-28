require 'spec_helper'

describe Gradebook do
  it 'has a class_period' do
    class_period = ClassPeriod.new()
    expect(Gradebook.new(class_period, nil)).to respond_to :class_period
  end

  it 'has the assignments in this class' do
    class_period = FactoryGirl.create(:class_period, :with_curriculum)
    expect(Gradebook.new(class_period, class_period.course.units.first).assignments.count).to eq 2
  end

  it 'has the students in this class' do
    student = FactoryGirl.build_stubbed(:student)
    class_period = ClassPeriod.new(students: [student])
    expect(Gradebook.new(class_period, nil).students.size).to eq 1
  end

  describe '#points_possible' do
    it 'totals the possible points for all assignments' do
      assignments = FactoryGirl.build_list(:assignment, 3)
      assignments << FactoryGirl.build_stubbed(:assignment, ixl_points_possible: nil)
      class_period = FactoryGirl.build_stubbed(:class_period)
      unit = double('unit')
      allow(unit).to receive(:assignments).and_return assignments

      expect(Gradebook.new(class_period, unit).total_points_possible). to eq 27
    end

    it 'does not include stars in the total' do
      assignment = Assignment.new(notes_points_possible: 1,
                                  ixl_points_possible: 2,
                                  worksheet_points_possible: 3,
                                  star_points_possible: 4)
      class_period = FactoryGirl.build_stubbed(:class_period)
      unit = double('unit')
      allow(unit).to receive(:assignments).and_return [assignment]
      expect(Gradebook.new(class_period, unit).total_points_possible). to eq 6
    end
  end

  describe '#percentage_for' do
    it 'returns 0 if total points is 0' do
      unit = Unit.new(assignments: [Assignment.new(notes_points_possible:0)])
      student = Student.first

      expect(Gradebook.new(nil, unit).percentage_for(student)).to eq 0
    end

    it 'provides the percentage of earned points to possible points for a student' do
      class_period = FactoryGirl.create(:class_period, :with_curriculum, :with_students)
      student = Student.first

      ClassAssignment.create(assignment: class_period.assignments.first, student_class: student.student_classes.first,
                             points_earned: 1)
      ClassAssignment.create(assignment: class_period.assignments.second, student_class: student.student_classes.first,
                             points_earned: 2, notes_earned: 1)

      expect(Gradebook.new(class_period, class_period.course.units.first).percentage_for(student)).to eq 29
    end
  end

  it 'totals the points earned by a student for the unit' do
    class_period = FactoryGirl.create(:class_period, :with_curriculum, :with_students)
    student = Student.first

    ClassAssignment.create(assignment: class_period.assignments.first, student_class: student.student_classes.first,
                           points_earned: 1)
    ClassAssignment.create(assignment: class_period.assignments.second, student_class: student.student_classes.first,
                           points_earned: 2, notes_earned: 1)

    expect(Gradebook.new(class_period, class_period.course.units.first).points_for(student)).to eq 4
  end

  describe '#setup_complete' do
    it 'returns false if there are no students' do
      class_period = FactoryGirl.create(:class_period, :with_curriculum)
      expect(Gradebook.new(class_period, class_period.course.units.first).setup_complete?).to eq false
    end
    it 'returns false if there are no assignments' do
      class_period = FactoryGirl.create(:class_period, :with_students)
      expect(Gradebook.new(class_period, class_period.course.units.first).setup_complete?).to eq false
    end
    it 'returns true if both students and assignments are present' do
      class_period = FactoryGirl.create(:class_period, :with_curriculum, :with_students)
      expect(Gradebook.new(class_period, class_period.course.units.first).setup_complete?).to eq true
    end
  end
end
