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
      unit = FactoryGirl.build_stubbed :unit, order: 7
      expect(unit.order).to eq 7

    end

    it 'defaults the order to the last item for the course it is related to' do
      course = FactoryGirl.build_stubbed :course
      course.units.build(name: 'one')
      course.units.build(name: 'two')
      course.units << Unit.new(name: 'bla', order: 3)
      unit = course.units.build(name: 'foo')
      expect(unit.order).to eq 4
    end
  end
end
