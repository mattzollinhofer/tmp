require 'rails_helper'

RSpec.describe TeacherCourse do
  it { is_expected.to belong_to :teacher }
  it { is_expected.to belong_to :course }

  it { is_expected.to validate_presence_of :teacher }
end
