feature 'Teacher Visits Homepage' do
  scenario 'successfully' do
    teacher = FactoryGirl.create(:teacher)
    login_as(teacher.user, scope: :user)

    visit '/'

    expect(page).to have_css 'span', text: "Welcome, #{teacher.user.first_name}"
  end
end
