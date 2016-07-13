feature 'Teacher creates a new course' do
  scenario 'successfully' do
    teacher = FactoryGirl.create(:teacher)
    login_as(teacher, scope: :user)

    visit courses_path

    click_on 'Create a new course'
    fill_in 'course[name]', with: 'Course Name 101'
    click_on 'Create Course'

    expect(page).to have_css '.courses li', text: 'Course Name 101'
    expect(page).not_to have_css '.courses li', text: 'taught by'
  end
end
