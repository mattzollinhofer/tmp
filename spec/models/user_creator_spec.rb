require 'rails_helper'

RSpec.describe UserCreator do
  describe '#from_omniauth' do
    context 'when user exists' do
      it 'returns the existing user' do
        email = 'test@test.com'
        user = FactoryBot.create(:user, email: email)

        # Act like you're in prod
        allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("production"))
        access_token = double(:access_token, info: {email: email})
        expect(UserCreator.from_omniauth(access_token)).to eq user
      end
    end
    context 'when no user exists' do
      context 'and the email belongs to this school' do
        context 'and there is a two digit number before the @ sign' do
          it 'creates a new student' do
            # Act like you're in prod
            allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("production"))

            access_token = double(:access_token, info: {email: 'fool16@school.com'})
            expect(UserCreator.from_omniauth(access_token)).to be_a Student
          end
        end

        it 'creates a new guest when the email does not end in a two digit number' do
          # Act like you're in prod
          allow(Rails).to receive(:env).and_return(ActiveSupport::StringInquirer.new("production"))

          access_token = double(:access_token, info: {email: 'teach@school.com'})
          student = UserCreator.from_omniauth(access_token)
          expect(student).to be_a Guest
        end
      end
    end
  end
end
