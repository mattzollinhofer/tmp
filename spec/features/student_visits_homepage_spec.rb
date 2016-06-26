require 'rails_helper'

feature 'Student Visits Homepage' do
  scenario 'successfully' do
    student = FactoryGirl.create(:student)
    login_as(student, scope: :user)

    visit '/'

    expect(page).to have_css 'h1', text: 'Courses'
    expect(page).to have_css 'p', text: "You don't have any courses"
  end
end

