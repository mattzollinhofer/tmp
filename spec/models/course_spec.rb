require 'rails_helper'

RSpec.describe Course do
  it { is_expected.to have_attribute :name }

  it { is_expected.to have_many :assignments }
  it { is_expected.to have_many :student_courses }
  it { is_expected.to have_many(:students).through :student_courses }
  it { is_expected.to have_many :teacher_courses }
  it { is_expected.to have_many(:teachers).through :teacher_courses}
end
