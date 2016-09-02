feature 'Teacher creates unit for course' do
  scenario 'successfully' do
    course = FactoryGirl.create(:course)
    teacher = FactoryGirl.create(:teacher)
    login_as(teacher, scope: :user)

    visit courses_path

    click_on course.to_s
    click_on 'Create a New Unit'
    fill_in 'unit_name', with: 'Unit Foo 1'
    click_on 'Create Unit'

    expect(page).to have_css '.units li', text: 'Unit Foo 1'
  end
end
