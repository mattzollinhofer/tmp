require 'rails_helper'

RSpec.describe Teacher do
  it { is_expected.to have_many :teacher_classes }
  it { is_expected.to have_many(:class_periods).through :teacher_classes }
end
