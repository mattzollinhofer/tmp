feature 'Teacher creates, edits, and deletes an assignment for unit', js: true do
  scenario 'successfully' do
    unit = FactoryGirl.create(:unit)
    teacher = FactoryGirl.create(:teacher)
    login_as(teacher, scope: :user)

    visit unit_path unit

    click_on 'New Assignment'
    fill_in 'assignment_name', with: 'assignment Foo 1'
    fill_in 'assignment_points_possible', with: '4'
    fill_in 'assignment_stars_possible', with: '3'
    click_on 'Create Assignment'

    expect(page).to have_css '.assignments li', text: 'assignment Foo 1'
    expect(page).to have_css '.assignments li', text: 'Points: 4'
    expect(page).to have_css '.assignments li', text: 'Stars: 3'

    click_on 'Edit'
    fill_in 'assignment_name', with: 'assignment 1'
    fill_in 'assignment_points_possible', with: '5'
    fill_in 'assignment_stars_possible', with: '2'
    click_on 'Update Assignment'

    expect(page).to have_css '.assignments li', text: 'assignment 1'
    expect(page).to have_css '.assignments li', text: 'Points: 5'
    expect(page).to have_css '.assignments li', text: 'Stars: 2'

    page.accept_confirm do
      click_link 'Delete'
    end
    expect(page).not_to have_css '.assignments li', text: 'assignment 1'
  end
end
