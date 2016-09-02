feature 'Teacher creates, edits, and deletes an assignment for unit', js: true do
  scenario 'successfully' do
    unit = FactoryGirl.create(:unit)
    teacher = FactoryGirl.create(:teacher)
    login_as(teacher, scope: :user)

    visit unit_path unit

    click_on 'Create a New Assignment'
    fill_in 'assignment_name', with: 'assignment Foo 1'
    click_on 'Create Assignment'

    expect(page).to have_css '.assignments li', text: 'assignment Foo 1'

    click_on 'edit'
    fill_in 'assignment_name', with: 'assignment 1'
    click_on 'Update Assignment'

    expect(page).to have_css '.assignments li', text: 'assignment 1'

    page.accept_confirm do
      click_link 'delete'
    end
    expect(page).not_to have_css '.assignments li', text: 'assignment 1'
  end
end
