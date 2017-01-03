require 'spec_helper'

describe AssignmentStatus do
  describe '#status' do
    it 'returns NOT_STARTED when no assignments have received a grade' do
      assignment = Assignment.new(worksheet_points_possible: 2,
                                  ixl_points_possible: 3,
                                  notes_points_possible: 1)
      class_assignment = ClassAssignment.new(assignment: assignment)
      expect(AssignmentStatus.new(class_assignment).status).to eq AssignmentStatus::NOT_STARTED
    end
    it 'returns STARTED when some assignments have received a grade' do
      assignment = Assignment.new(worksheet_points_possible: 2,
                                  ixl_points_possible: 3,
                                  notes_points_possible: 1)
      class_assignment = ClassAssignment.new(assignment: assignment, notes_earned: 1)
      expect(AssignmentStatus.new(class_assignment).status).to eq AssignmentStatus::STARTED
    end
    it 'returns DONE when all assignments have received a grade' do
      assignment = Assignment.new(worksheet_points_possible: 2,
                                  ixl_points_possible: 3,
                                  notes_points_possible: 1)

      class_assignment = ClassAssignment.new(assignment: assignment,
                                             points_earned: 1,
                                             ixl_earned: 2,
                                             notes_earned: 1)

      expect(AssignmentStatus.new(class_assignment).status).to eq AssignmentStatus::DONE
    end
    it 'returns PERFECT when all assignments received full credit' do
      assignment = Assignment.new(worksheet_points_possible: 2,
                                  star_points_possible: 0,
                                  notes_points_possible: 1)

      class_assignment = ClassAssignment.new(assignment: assignment,
                                             points_earned: 2,
                                             notes_earned: 1)

      expect(AssignmentStatus.new(class_assignment).status).to eq AssignmentStatus::PERFECT
    end
  end

  describe '#overdue_status' do
    it 'returns "overdue" when it is overdue' do
      assignment = Assignment.new(due_at: (Date.today-1).strftime('%m/%d/%Y'))
      expect(AssignmentStatus.new(ClassAssignment.new(assignment: assignment)).overdue_status).to eq 'overdue'
    end
    it 'returns an empty string when not overdue' do
      expect(AssignmentStatus.new(ClassAssignment.new).overdue_status).to eq ''
    end
  end

  describe '#battery_level' do
    it 'returns EMPTY when NOT_STARTED' do
      assignment_status = AssignmentStatus.new(double(ClassAssignment))
      expect(assignment_status.battery_level(progress: AssignmentStatus::NOT_STARTED)).to eq AssignmentStatus::EMPTY
    end
    it 'returns HALF_FULL when STARTED' do
      assignment_status = AssignmentStatus.new(double(ClassAssignment))
      expect(assignment_status.battery_level(progress: AssignmentStatus::STARTED)).to eq AssignmentStatus::HALF_FULL
    end
    it 'returns FULL when DONE' do
      assignment_status = AssignmentStatus.new(double(ClassAssignment))
      expect(assignment_status.battery_level(progress: AssignmentStatus::DONE)).to eq AssignmentStatus::FULL
    end
    it 'returns FULL when PERFECT' do
      assignment_status = AssignmentStatus.new(double(ClassAssignment))
      expect(assignment_status.battery_level(progress: AssignmentStatus::PERFECT)).to eq AssignmentStatus::FULL
    end
  end
end
