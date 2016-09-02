feature 'Teacher creates assignment for unit' do
  scenario 'successfully' do
    unit = FactoryGirl.create(:unit)
    teacher = FactoryGirl.create(:teacher)
    login_as(teacher, scope: :user)

    visit unit_path unit

    click_on 'Create a New Assignment'
    fill_in 'assignment_name', with: 'assignment Foo 1'
    click_on 'Create Assignment'

    expect(page).to have_css '.assignments li', text: 'assignment Foo 1'
  end
end
