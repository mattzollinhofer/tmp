require 'rails_helper'

RSpec.describe Student do
  it { is_expected.to have_attribute :nickname }

  it 'pulls graduation year from the last two digits of the email address' do
    email = 'fool16@school.com'
    expect(Student.new(email: email).graduation_year).to eq Date.today.year.to_s.first(2)+'16'
  end

  it 'has a valid factory' do
    student = FactoryBot.build_stubbed(:student)
    student.valid?
    expect(student.errors).to be_empty
  end

  describe 'display_name' do
    it 'uses nickname if it exists' do
      subject.last_name = 'King'
      subject.first_name = 'William'
      subject.nickname = 'Bill'
      expect(subject.display_name).to eq 'King, Bill'
    end

    it 'returns first name if nickname does not exist' do
      subject.first_name = 'John'
      subject.last_name = 'King'
      expect(subject.display_name).to eq 'King, John'
    end
  end
end
