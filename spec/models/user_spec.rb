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

  it { is_expected.to validate_inclusion_of(:admin).in_array([true, false]) }

  it 'validates the uniqueness of email' do
    original = FactoryGirl.create(:user, email: 'test@test.com')
    duplicate = FactoryGirl.build(:user, email: original.email)
    duplicate.valid?
    expect(duplicate.errors[:email]).to include 'has already been taken'
  end

  describe '#from_omniauth' do
    context 'when user exists' do
      it 'returns the existing user' do
        email = 'test@test.com'
        user = FactoryGirl.create(:user, email: email)
        access_token = double(:access_token, info: {email: email})
        expect(User.from_omniauth(access_token)).to eq user
      end
    end
    context 'when no user exists' do
      context 'and the email belongs to this school' do
        context 'and there is a two digit number before the @ sign' do
          it 'creates a new student' do
            access_token = double(:access_token, info: {email: 'fool16@school.com'})
            expect(User.from_omniauth(access_token)).to be_a Student
          end
          it 'uses the two digit number as the graduation year' do
            access_token = double(:access_token, info: {email: 'fool16@school.com'})
            expect(User.from_omniauth(access_token).graduation_year).to eq 16
          end
        end

        it 'creates a new teacher when the email does not end in a two digit number' do
          access_token = double(:access_token, info: {email: 'teach@school.com'})
          student = User.from_omniauth(access_token)
          expect(student).to be_a Teacher
        end
      end
    end
  end

end
