feature 'Teacher Visits Homepage' do
  scenario 'successfully' do
    teacher = FactoryGirl.create(:teacher)
    login_as(teacher, scope: :user)

    visit '/'

    expect(page).to have_css '.nav-bar', text: 'Planning'
    expect(page).to have_css 'span', text: "Welcome, #{teacher.first_name}"
  end
end
