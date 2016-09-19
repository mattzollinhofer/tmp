require 'rails_helper'

RSpec.describe ClassPeriodHelper do
  describe 'class_period_short_label' do
    it 'displays the course name, year, class period' do
      class_period = FactoryGirl.build_stubbed(:class_period)
      output = class_period_short_label(class_period)
      expect(output).to include("Period: #{class_period.period.to_s}")
      expect(output).to include(class_period.course.name.capitalize)
      expect(output).not_to include(class_period.course.year.to_s)
    end
  end

  describe 'class_period_label' do
    it 'displays the course name, year, class period, and teachers' do
      class_period = FactoryGirl.build_stubbed(:class_period)
      output = class_period_label(class_period)
      expect(output).to include("Period: #{class_period.period.to_s}")
      expect(output).to include(class_period.course.name.capitalize)
      expect(output).not_to include(class_period.course.year.to_s)
      expect(output).to include(class_period.teacher_names)
      expect(class_period.teachers.present?).to eq true
    end

    it 'displays a question mark if there are no teachers assigned' do
      class_period = FactoryGirl.build_stubbed(:class_period)
      class_period.teachers = []
      output = class_period_label(class_period)

      expect(output).to include('?')
    end
  end

  describe 'taught_by_teachers' do
    it 'prints out the teachers who teach the course' do
      class_period = FactoryGirl.build_stubbed(:class_period)
      expect(taught_by_teachers(class_period)).to include "Taught by: #{class_period.teacher_names}"
    end
  end
end
