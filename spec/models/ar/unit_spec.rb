require 'rails_helper'

RSpec.describe Unit do
  it { is_expected.to have_attribute :name }
  it { is_expected.to have_attribute :order }

  it { is_expected.to belong_to :course }

  describe '#default_order' do
    it 'returns nil if not associated to a course' do
      unit = Unit.new
      expect(unit.order).to be_nil
    end

    it 'returns order if already set' do
      unit = FactoryBot.build_stubbed :unit, order: 7
      expect(unit.order).to eq 7

    end

    it 'defaults the order to the last item for the course it is related to' do
      course = Course.new
      course.units.build(name: 'one')
      course.units.build(name: 'two')
      course.units << Unit.new(name: 'bla', order: 3)
      unit = course.units.build(name: 'foo')
      expect(unit.order).to eq 4
    end
  end

  describe '#possible_points' do
    it 'sums all assignment possible points' do
      assignments = []
      assignments << Assignment.new(notes_points_possible: 2, ixl_points_possible: 4)
      assignments << Assignment.new(notes_points_possible: 2, ixl_points_possible: 4)
      assignments << Assignment.new(worksheet_points_possible: 2, ixl_points_possible: 4)
      unit = Unit.new(name: 'foo', assignments: assignments)

      expect(unit.possible_points).to eq 18
    end
    it 'returns 0 if no assignments' do
      unit = Unit.new(name: 'foo')
      expect(unit.possible_points).to eq 0
    end
  end

  context 'visible or hidden from students' do
    it 'is hidden by default' do
      unit = Unit.new()
      expect(unit.visible).to eq false
    end
    it 'can be hidden' do
      unit = Unit.new(visible: true)
      unit.visible = false
      expect(unit.visible).to eq false
    end
    it 'can can be visible' do
      unit = Unit.new(visible: true)
      expect(unit.visible).to eq true
    end
  end
end
