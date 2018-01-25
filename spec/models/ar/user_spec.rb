require 'rails_helper'

RSpec.describe User do
  it { is_expected.to have_attribute :first_name }
  it { is_expected.to have_attribute :last_name }
  it { is_expected.to have_attribute :email }
  it { is_expected.to have_attribute :mobile_number }
  it { is_expected.to have_attribute :admin }

  %w(first_name last_name email).each do |required_attribute|
    it { is_expected.to have_attribute required_attribute }
    it { is_expected.to validate_presence_of required_attribute }
  end

  it 'validates the uniqueness of email' do
    original = FactoryBot.create(:user, email: 'test@test.com')
    duplicate = FactoryBot.build(:user, email: original.email)
    duplicate.valid?
    expect(duplicate.errors[:email]).to include 'has already been taken'
  end
end
