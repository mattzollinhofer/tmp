require 'rails_helper'

RSpec.describe CourseHelper do
  describe 'course_link' do
    it 'provides a link to the course' do
      course = FactoryGirl.build_stubbed(:course)
      expect(course_link(course)).to include(course_path(course))
    end
    it 'capatilizes the name of the course as the text' do
      course = FactoryGirl.build_stubbed(:course, name: 'english 101')
      expect(course_link(course)).to include('>English 101<')
    end
  end
end
