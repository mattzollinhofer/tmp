require 'course_helper'

feature 'Teacher Visits Gradebook' do
  include ClassPeriodHelper

  scenario 'successfully' do
    course = FactoryGirl.create(:course_with_units_and_assignments)
    teacher = FactoryGirl.create(:teacher)
    class_period = FactoryGirl.create(:class_period_with_students, course: course, teachers: [teacher])
    login_as(teacher, scope: :user)

    visit gradebook_path class_period

    expect(page).to have_css 'h2', text: class_period_short_label(class_period)
    expect(page).to have_css 'table.gradebook'
    expect(page).to have_css 'th.assignments-header'
    expect(page).to have_css 'th', text: "Student"
    # TODO add these back in when ready to test this
    #expect(page).to have_css 'th', text: "#{course.assignments[0].name}"
    #expect(page).to have_css 'th', text: "#{course.assignments[1].name}"
    #expect(page).to have_css 'th', text: "#{course.assignments[2].name}"
    #expect(page).to have_css 'th', text: "#{course.assignments[3].name}"

    expect(page).to have_css 'td', text: "#{class_period.students[0].display_name}"
    expect(page).to have_css 'td', text: "#{class_period.students[1].display_name}"
    expect(page).to have_css 'td', text: "#{class_period.students[2].display_name}"
    expect(page).to have_css 'td', text: "#{class_period.students[3].display_name}"
  end
end
