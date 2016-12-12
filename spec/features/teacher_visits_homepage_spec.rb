require 'course_helper'

feature 'Teacher Visits Homepage' do
  scenario 'successfully' do
    course = FactoryGirl.create(:course_with_units_and_assignments)
    class_period = FactoryGirl.create(:class_period_with_teachers, course: course)
    teacher = class_period.teachers.first
    login_as(teacher, scope: :user)

    visit '/'

    expect(page).to have_css 'a', text: "Hi, #{teacher.first_name}"
    expect(page).to have_css '.class-periods li a',
                    text: "#{course.name.capitalize}"
    expect(page).to have_css ".class-periods li a[href='/gradebooks/#{class_period.id}']"
    expect(page).to have_css '.class-periods li',
                    text: "Period: #{class_period.period}"
  end
end
