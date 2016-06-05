require 'rails_helper'

feature 'Student Visits Homepage' do
  scenario 'successfully' do
    student = FactoryGirl.create(:student)
    login_as(student.user, scope: :user)

    visit '/'

    expect(page).to have_css 'h1', text: 'All Courses'
  end
end

