feature 'Teacher is Assigned to Teach Class' do
  scenario 'successfully' do
    teacher = FactoryGirl.create(:teacher)
    login_as(teacher, scope: :user)
    course = FactoryGirl.create(:course_with_units_and_assignments)

    visit planning_path

    expect(page).to have_css 'li', text: 'Manage Students'
    expect(page).to have_css 'a', text: 'Manage Courses'
    expect(page).to have_css 'a', text: 'Manage Class Periods'
    expect(page).to have_css 'li', text: 'Manage Teachers'

    click_on 'Manage Class Periods'
    expect(page).to have_css '.class-periods li', text: "No Class Periods"

    click_on 'Create a new class period'
    select course.name, from: 'class_period[course_id]'
    fill_in 'class_period[period]', with: '2'
    click_on 'Create Class Period'

    expect(page).to have_css '.class-periods li', text: "#{course.to_s} - Period: 2"
    expect(page).to have_css '.class-periods li a', text: "#{course.to_s}"

    visit class_periods_path

    click_on 'edit'
    fill_in 'class_period[period]', with: '3'
    click_on 'Create Class Period'
    expect(page).to have_css '.class-periods li', text: "#{course.to_s} - Period: 3"
  end
end
