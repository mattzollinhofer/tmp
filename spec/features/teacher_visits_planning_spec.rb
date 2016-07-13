feature 'Teacher Visits Planning Page' do
  scenario 'successfully' do
    teacher = FactoryGirl.create(:teacher)
    login_as(teacher, scope: :user)

    visit planning_path

    expect(page).to have_css 'li', text: 'Manage Students'
    expect(page).to have_css 'a', text: 'Manage Courses'
    expect(page).to have_css 'li', text: 'Manage Class Periods'
    expect(page).to have_css 'li', text: 'Manage Teachers'
  end
end
