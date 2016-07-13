require 'rails_helper'

RSpec.describe StudentClass do
  it { is_expected.to belong_to :student }
  it { is_expected.to validate_presence_of :student }

  it { is_expected.to belong_to :class_period }
  it { is_expected.to validate_presence_of :class_period }
end
