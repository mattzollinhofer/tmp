require 'rails_helper'

RSpec.describe ClassPeriodHelper do
  describe 'class_period_label' do
    let (:course)  { FactoryGirl.build_stubbed(:course) }
    let (:teachers)  { FactoryGirl.build_list(:teacher, 2) }
    let (:class_period) { FactoryGirl.build_stubbed(:class_period, teachers: teachers, course: course) }

    it 'includes the link to the course' do
      expect(class_period_label(class_period)).to include("#{link_to course, course.name.capitalize}")
    end
    it 'includes the period it is being taught' do
      expect(class_period_label(class_period)).to include("Period: #{class_period.period}")
    end
    it 'includes the teacher(s) teaching it' do
      expect(class_period_label(class_period)).to include("Taught by: #{class_period.teachers.map(&:name).join(', ')}")
    end
  end
end
