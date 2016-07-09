require 'rails_helper'

feature 'User Logs Out' do
  scenario 'successfully' do
    student = FactoryGirl.create(:student)
    login_as(student, scope: :user)
    visit '/'

    click_on 'Sign Out'

    expect(page).to have_css 'h2', text: 'Sign in'
    expect(page).to have_css 'a', text: 'Sign in with Google'
  end
end
