feature 'Student is Assigned to Class' do
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

    visit class_period_path(class_period)

    expect(page).to have_css '.students li', text: "#{student.display_name}"
  end
end
