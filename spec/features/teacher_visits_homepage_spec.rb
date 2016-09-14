require 'course_helper'

feature 'Teacher Visits Homepage' do
  scenario 'successfully' do
    course = FactoryGirl.create(:course_with_units_and_assignments)
    class_period = FactoryGirl.create(:class_period, course: course)
    teacher = class_period.teachers.first
    login_as(teacher, scope: :user)

    visit '/'

    expect(page).to have_css '.nav-bar', text: 'Planning'
    expect(page).to have_css 'span', text: "Welcome, #{teacher.first_name}"
    expect(page).to have_css '.class-periods li',
      text: "#{course.name.capitalize}"
    expect(page).to have_css '.class-periods li',
      text: "Period: #{class_period.period}"
    expect(page).to have_css '.class-periods li',
      text: "- Taught by: #{class_period.teachers.map(&:name).join(', ')}"
  end
end
