require 'rails_helper'

feature 'Student Visits Homepage' do
  scenario 'successfully' do
    student = FactoryGirl.create(:student)
    login_as(student, scope: :user)

    visit '/'

    expect(page).to have_css 'span', text: "Welcome, #{student.first_name}"
  end
end

