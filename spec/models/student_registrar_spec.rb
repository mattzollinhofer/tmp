require 'rails_helper'

describe StudentRegistrar do
  describe '#enroll' do
    it 'does nothing when no students are provided'
    xit 'assigns new students to the class period' do
      class_period = FactoryGirl.build_stubbed(:class_period)
      students = FactoryGirl.build_stubbed(:student)
    end
    it 'creates assignments for new students'
    it 'does not create duplicate assignments for students previously enrolled'
  end
end
