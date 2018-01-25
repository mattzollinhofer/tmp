require 'course_helper'

feature 'Teacher Visits Gradebook' do
  include ClassPeriodHelper

  scenario 'successfully' do
    course = FactoryBot.create(:course_with_units_and_assignments)
    teacher = FactoryBot.create(:teacher)
    class_period = FactoryBot.create(:class_period, :with_students, course: course, teachers: [teacher])
    login_as(teacher, scope: :user)

    visit gradebook_path class_period, course.units.first

    expect(page).to have_css 'strong', text: class_period_short_label(class_period)
    expect(page).to have_css 'table.gradebook'
    expect(page).to have_css 'th.assignments-header'
    expect(page).to have_css 'th', text: "Student"
    expect(page).to have_css 'th', text: "Total (14)"
    expect(page).to have_css 'th', text: "#{course.assignments[0].name}"
    expect(page).to have_css 'th', text: "#{course.assignments[1].name}"

    expect(page).to have_css 'td', text: "#{class_period.students[0].display_name}"
    expect(page).to have_css 'td', text: "#{class_period.students[1].display_name}"
    expect(page).to have_css 'td', text: "#{class_period.students[2].display_name}"
    expect(page).to have_css 'td', text: "#{class_period.students[3].display_name}"
  end
end
