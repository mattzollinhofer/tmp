require 'rails_helper'

feature 'User Logs Out' do
  scenario 'successfully' do
    student = FactoryGirl.create(:student)
    login_as(student, scope: :user)
    visit '/'

    click_on 'Sign Out'

    expect(page).to have_css '.h1', text: 'Sign In!!'
    expect(page).to have_css 'a', text: 'With Gmail'
  end
end
