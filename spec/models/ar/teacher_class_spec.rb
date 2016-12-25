require 'rails_helper'

RSpec.describe TeacherClass do
  it { is_expected.to belong_to :teacher }
  it { is_expected.to belong_to :class_period }

  it { is_expected.to validate_presence_of :teacher }
  it { is_expected.to validate_presence_of :class_period }
end
