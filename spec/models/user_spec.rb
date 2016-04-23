require 'rails_helper'

RSpec.describe User do
  it { is_expected.to have_attribute :first_name }
  it { is_expected.to have_attribute :last_name }
  it { is_expected.to have_attribute :email }
  it { is_expected.to have_attribute :mobile_number }

  %w(first_name last_name email).each do |required_attribute|
    it { is_expected.to have_attribute required_attribute }
    it { is_expected.to validate_presence_of required_attribute }
  end

  %w(mobile_number).each do |attribute|
    it { is_expected.to have_attribute attribute }
    it { is_expected.not_to validate_presence_of attribute }
  end

  it 'validates the uniqueness of email' do
    original = FactoryGirl.create(:user, email: 'test@test.com')
    duplicate = FactoryGirl.build(:user, email: original.email)
    duplicate.valid?
    expect(duplicate.errors[:email]).to include 'has already been taken'
  end

  it 'validates the uniqueness of mobile_number' do
    original = FactoryGirl.create(:user, mobile_number: '123-123-1234')
    duplicate = FactoryGirl.build(:user, mobile_number: original.mobile_number)
    duplicate.valid?
    expect(duplicate.errors[:mobile_number]).to include 'has already been taken'
  end
end
