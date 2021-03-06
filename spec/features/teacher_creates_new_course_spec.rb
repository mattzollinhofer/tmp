feature 'Teacher creates a new course' do
  scenario 'successfully' do
    teacher = FactoryBot.create(:teacher)
    login_as(teacher, scope: :user)

    visit courses_path

    click_on 'Create One'
    fill_in 'course[name]', with: 'Course Name 101'
    fill_in 'course[year]', with: '1999'
    click_on 'Create Course'

    expect(page).to have_css '.courses li', text: 'Course Name 101 [1999-2000]'
  end
end
