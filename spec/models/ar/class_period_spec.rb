require 'rails_helper'

RSpec.describe ClassPeriod do
  it { is_expected.to belong_to :course }
  it { is_expected.to have_attribute :period }

  it { is_expected.to have_many :teacher_classes }
  it { is_expected.to have_many(:teachers).through :teacher_classes }

  it { is_expected.to have_many :student_classes }
  it { is_expected.to have_many(:students).through :student_classes }

  describe 'teacher_names' do
    it "prints a comma delimted list of teacher names" do
      class_period = ClassPeriod.new
      class_period.teachers = FactoryBot.build_list(:teacher, 3)

      expect(class_period.teachers.present?).to be true
      expect(class_period.teacher_names).to eq "#{class_period.teachers.first.name}, #{class_period.teachers.second.name}, and #{class_period.teachers.third.name}"
    end
  end
end
