require 'rails_helper'

RSpec.describe ClassPeriod do
  it { is_expected.to belong_to :course }

  it { is_expected.to have_many :teacher_classes }
  it { is_expected.to have_many(:teachers).through :teacher_classes }

  it { is_expected.to have_many :student_classes }
  it { is_expected.to have_many(:students).through :student_classes }
end
