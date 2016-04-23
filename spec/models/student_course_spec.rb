require 'rails_helper'

RSpec.describe StudentCourse do
  it { is_expected.to belong_to :student }
  it { is_expected.to belong_to :course }

  it { is_expected.to validate_presence_of :student }
  it { is_expected.to validate_presence_of :course }
end
