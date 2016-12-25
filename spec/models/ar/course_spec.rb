require 'rails_helper'

RSpec.describe Course do
  it { is_expected.to have_attribute :name }
  it { validate_presence_of :name }
  it do
    should validate_inclusion_of(:year)
             .in_range(1900..Date.today.year+50)
             .with_message('should be a four-digit year')
  end

  it { is_expected.to have_many :units }

  describe 'to_s' do
    let (:brian)   { FactoryGirl.build_stubbed(:teacher) }
    let (:christi)   { FactoryGirl.build_stubbed(:teacher) }
    let (:subject) { Course.new(name: 'Math 100', year: 1999) }

    it 'should print a friendly version of itself' do
      expect(subject.to_s).to eq "Math 100 (1999-2000)"
    end
  end

  describe 'year' do
    it 'defaults to the current year' do
      expect(subject.year).to eq Time.now.year
    end
  end

  describe 'assignments' do
    it 'returns assignments for all units' do
      unit1 = Unit.new(name: 'foo',
                       assignments: FactoryGirl.build_stubbed_list(:assignment, 3))
      unit2 = Unit.new(name: 'foo',
                       assignments: FactoryGirl.build_stubbed_list(:assignment, 1))

      course = Course.new(units: [unit1, unit2])

      expect(course.assignments.count).to eq(4)
      expect(course.assignments.map(&:name)).to include unit2.assignments.first.name
    end
  end

  describe 'total_assignments' do
    it 'reports the total number of assignments for all units' do
      unit1 = FactoryGirl.build_stubbed(:unit, assignments: FactoryGirl.build_stubbed_list(:assignment, 2))
      unit2 = FactoryGirl.build_stubbed(:unit, assignments: [FactoryGirl.build_stubbed(:assignment)])
      course = Course.new(units: [unit1, unit2])

      total_assignments = unit1.assignments.size + unit2.assignments.size
      expect(course.total_assignments).to eq total_assignments
    end
  end
end
