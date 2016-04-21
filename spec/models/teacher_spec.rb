require 'rails_helper'

RSpec.describe Teacher do
  it { is_expected.to belong_to :user }
  it { is_expected.to have_many :teacher_courses }
  it { is_expected.to have_many(:courses).through :teacher_courses }
  it { is_expected.to have_many(:students).through :courses }
end
