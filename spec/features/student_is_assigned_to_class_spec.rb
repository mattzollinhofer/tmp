feature 'Student is added to class' do
  include ClassPeriodHelper

  scenario 'successfully' do
    student = FactoryGirl.create(:student, first_name: 'foo', last_name: 'bar')
    course = FactoryGirl.create(:course_with_units_and_assignments)
    class_period = FactoryGirl.create(:class_period_with_teachers, course: course)
    login_as(class_period.teachers.first, scope: :user)

    visit class_periods_path
    expect(page).to have_css '.class-period a', text: "#{class_period.course.name}"

    click_on 'manage students'
    select student.display_name, from: 'class_period_student_ids'
    click_on 'Update Class period'

    expect(page).to have_select('class_period[student_ids][]', selected: "#{student.display_name}")

    visit gradebook_path class_period
    expect(page).to have_css '.student .assignment', text: course.units.first.assignments.map(&:name).join(', ')

  end
end
