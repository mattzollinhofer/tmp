require 'rails_helper'

RSpec.describe Course do
  it { is_expected.to have_attribute :name }
  it { validate_presence_of :name }

  it { is_expected.to have_many :assignments }
  it { is_expected.to have_many :student_courses }
  it { is_expected.to have_many(:students).through :student_courses }
  it { is_expected.to have_many :teacher_courses }
  it { is_expected.to have_many(:teachers).through :teacher_courses}

  describe 'to_s' do
    let (:brian)   { FactoryGirl.build_stubbed(:teacher) }
    let (:christi)   { FactoryGirl.build_stubbed(:teacher) }
    let (:subject) { Course.new(name: 'Math 100', teachers: [brian, christi]) }
    it 'should print a friendly version of itself' do
      expect(subject.to_s).to eq "Math 100, taught by #{brian.first_name}, #{christi.first_name}"
    end
  end
end
