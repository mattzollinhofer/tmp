feature 'Teacher Visits Homepage' do
  scenario 'successfully' do
    teacher = FactoryGirl.create(:teacher)
    login_as(teacher, scope: :user)

    visit '/'

    expect(page).to have_css 'span', text: "Welcome, #{teacher.first_name}"
    expect(page).to have_css 'a', text: 'Planning'
  end
end
