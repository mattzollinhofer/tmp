feature 'Teacher is Assigned to Teach Class' do
  scenario 'successfully' do
    teacher1 = FactoryGirl.create(:teacher)
    teacher2 = FactoryGirl.create(:teacher)
    login_as(teacher1, scope: :user)
    course = FactoryGirl.create(:course_with_units_and_assignments)

    visit courses_path

    expect(page).to have_css 'a', text: 'Manage Courses'
    expect(page).to have_css 'a', text: 'Manage Class Periods'

    click_on 'Manage Class Periods'
    expect(page).to have_css '.jumbotron', text: 'There are no class periods!'

    click_on 'Create One'
    select teacher1.name, from: 'class_period_teacher_ids'
    select course.name, from: 'class_period[course_id]'
    fill_in 'class_period[period]', with: '2'
    click_on 'Create Class period'

    expect(page).to have_css '.class-periods li a', text: "#{course.name} Period: 2 - Taught by: #{teacher1.name}"

    visit class_periods_path

    click_link "#{course.name} Period: 2"
    expect(page).to have_css 'h1', text: "#{course.name} Period: 2"
    expect(page).to have_css 'span', text: "Taught by: #{teacher1.name}"

    visit class_periods_path

    click_on 'Edit'
    select teacher2.name, from: 'class_period_teacher_ids'
    fill_in 'class_period[period]', with: '3'
    click_on 'Update Class period'
    expect(page).to have_css '.class-periods li', text: "#{course.name} Period: 3 - Taught by: #{teacher1.name} and #{teacher2.name}"
  end
end
