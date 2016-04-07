require 'rails_helper'

RSpec.describe Student do
  it { is_expected.to have_attribute :nickname }
  it { is_expected.to have_attribute :graduation_year }
  it { is_expected.to belong_to :user }

  %w(graduation_year).each do |required_attribute|
    it { is_expected.to have_attribute required_attribute }
    it { is_expected.to validate_presence_of required_attribute }
  end

  it 'validates graduation_year is a number' do
    subject.graduation_year = DateTime.new
    subject.valid?
    expect(subject.errors[:graduation_year]).to include 'must be an integer'
  end

  it 'validates graduation_year is a year' do
    subject.graduation_year = '111'
    subject.valid?
    expect(subject.errors[:graduation_year]).to include 'must be a four digit year'
  end

  it 'validates graduation_year is a number' do
    subject.graduation_year = 'foo'
    subject.valid?
    expect(subject.errors[:graduation_year]).to include 'is not a number'
  end

  it 'validates graduation_year is not earlier than today' do
    subject.graduation_year = (Date.today-1.year).year
    subject.valid?
    expect(subject.errors[:graduation_year])
      .to include 'must be between this year and 30 years from now'
  end

  it 'validates graduation_year is not later than 30 years from now' do
    subject.graduation_year = (Date.today+31.year).year
    subject.valid?
    expect(subject.errors[:graduation_year])
      .to include 'must be between this year and 30 years from now'
  end

  it 'has a valid factory' do
    student = FactoryGirl.build_stubbed(:student)
    student.valid?
    expect(student.errors).to be_empty
  end

  it 'displays nickname if it exists' do
    subject.nickname = 'Bob'
    puts
    puts subject.nickname
    puts subject.errors.empty?
    expect(subject.nickname).to eq 'Bob'
  end
    
  it 'displays first name if nickname does not exist' do
    subject.user = FactoryGirl.build_stubbed(:user)
    subject.user.first_name = 'Bobfirst'
    puts
    puts subject.user.first_name
    puts subject.errors.empty?
    puts subject.display_name
    expect(subject.display_name).to eq 'Bobfirst'
  end
  
#eyebug    
  
end
