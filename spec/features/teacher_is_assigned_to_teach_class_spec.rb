feature 'Teacher is Assigned to Teach Class', js: true do
  scenario 'successfully' do
    teacher1 = FactoryGirl.create(:teacher)
    teacher2 = FactoryGirl.create(:teacher)
    login_as(teacher1, scope: :user)
    course = FactoryGirl.create(:course_with_units_and_assignments)

    visit planning_path

    expect(page).to have_css 'li', text: 'Manage Students'
    expect(page).to have_css 'a', text: 'Manage Courses'
    expect(page).to have_css 'a', text: 'Manage Class Periods'
    expect(page).to have_css 'li', text: 'Manage Teachers'

    click_on 'Manage Class Periods'
    expect(page).to have_css '.class-periods li', text: "No Class Periods"

    click_on 'Create a new class period'
    select teacher1.name, from: 'class_period_teacher_ids'
    select course.name, from: 'class_period[course_id]'
    fill_in 'class_period[period]', with: '2'
    click_on 'Create Class period'

    expect(page).to have_css '.class-periods li', text: "#{course.to_s} - Period: 2 - Taught by: #{teacher1.name}"
    expect(page).to have_css '.class-periods li a', text: "#{course.to_s}"

    visit class_periods_path

    click_on 'edit'
    select teacher2.name, from: 'class_period_teacher_ids'
    fill_in 'class_period[period]', with: '3'
    click_on 'Update Class period'
    expect(page).to have_css '.class-periods li', text: "#{course.to_s} - Period: 3 - Taught by: #{teacher2.name}"

    page.accept_confirm do
      click_link 'delete'
    end
    expect(page).not_to have_css '.class-periods li', text: "#{course.to_s}"
  end
end
