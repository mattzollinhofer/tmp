require 'rails_helper'

RSpec.describe StudentCourse do
  it { is_expected.to belong_to :student }
  it { is_expected.to belong_to :course }
end
