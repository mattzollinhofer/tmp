require 'spec_helper'

describe ClassAssignment do
  it { is_expected.to have_attribute :completed_at }
  it { is_expected.to have_attribute :points_earned }
  it { is_expected.to have_attribute :stars_earned }
  it { is_expected.to have_attribute :notes_earned }
  it { is_expected.to have_attribute :ixl_earned }

  it { is_expected.to belong_to :student_class }
  it { is_expected.to belong_to :assignment}

  describe '#number_graded' do
    it 'returns 0 if no assignment types have been graded' do
      expect(ClassAssignment.new(notes_earned: 1).number_graded).to eq 1
    end
    it 'returns the number of assignment types that have been graded' do
      class_assignment = ClassAssignment.new(points_earned: 2, stars_earned: 3, ixl_earned: 4)
      expect(class_assignment.number_graded).to eq 3
    end
    it 'returns 4 if all assignment types have been graded' do
      class_assignment = ClassAssignment.new(notes_earned: 1, points_earned: 2, stars_earned: 3, ixl_earned: 4)
      expect(class_assignment.number_graded).to eq 4
    end
  end

  describe 'updating completed_at' do
    it 'updates completed_at when notes are updated' do
      assignment = Assignment.create(due_at: (Date.today-1).strftime('%m/%d/%Y'))
      class_assignment = ClassAssignment.create(assignment: assignment)
      expect(class_assignment.completed_at.present?).to be false
      class_assignment.notes_earned = 2
      class_assignment.save
      expect(class_assignment.completed_at.present?).to be true
    end
  end

  describe '#overdue?' do
    it 'is true when completed_at is empty and due_date is before today' do
      assignment = Assignment.new(due_at: (Date.today-1).strftime('%m/%d/%Y'))
      class_assignment = ClassAssignment.new(assignment: assignment)
      expect(class_assignment.overdue?).to eq true
    end
    it 'is false when due_at is not set' do
      expect(ClassAssignment.new.overdue?).to eq false
    end
    it 'is false when due_at has not yet come' do
      assignment = Assignment.new(due_at: (Date.today+1).strftime('%m/%d/%Y'))
      ca = ClassAssignment.new(assignment: assignment)
      expect(ca.overdue?).to eq false
    end
    it 'is false when completed_at has a value' do
      assignment = Assignment.create(due_at: (Date.today-1).strftime('%m/%d/%Y'))
      class_assignment = ClassAssignment.new(assignment: assignment, completed_at: Date.today-1)
      expect(class_assignment.overdue?).to eq false
    end
  end
end
