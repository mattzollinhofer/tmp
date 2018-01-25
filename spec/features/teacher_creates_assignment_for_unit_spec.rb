feature 'Teacher creates, edits, and deletes an assignment for unit', js: true do
  scenario 'successfully' do
    unit = FactoryBot.create(:unit)
    teacher = FactoryBot.create(:teacher)
    login_as(teacher, scope: :user)

    visit unit_path unit

    click_on 'Create One'
    fill_in 'assignment_name', with: 'assignment Foo 1'
    fill_in 'assignment_worksheet_points_possible', with: '4'
    fill_in 'assignment_star_points_possible', with: '3'
    fill_in 'assignment_ixl_points_possible', with: '2'
    fill_in 'assignment_notes_points_possible', with: '1'
    click_on 'Create Assignment'

    expect(page).to have_css '.assignments li', text: 'Assignment Foo 1'
    expect(page).to have_css '.assignments li', text: 'Points: 4'
    expect(page).to have_css '.assignments li', text: 'Stars: 3'
    expect(page).to have_css '.assignments li', text: 'IXL: 2'
    expect(page).to have_css '.assignments li', text: 'Notes: 1'

    click_on 'Edit'
    fill_in 'assignment_name', with: 'assignment 1'
    fill_in 'assignment_worksheet_points_possible', with: '5'
    fill_in 'assignment_star_points_possible', with: '2'
    fill_in 'assignment_ixl_points_possible', with: '1'
    fill_in 'assignment_notes_points_possible', with: '3'
    click_on 'Update Assignment'

    expect(page).to have_css '.assignments li', text: 'Assignment 1'
    expect(page).to have_css '.assignments li', text: 'Points: 5'
    expect(page).to have_css '.assignments li', text: 'Stars: 2'
    expect(page).to have_css '.assignments li', text: 'IXL: 1'
    expect(page).to have_css '.assignments li', text: 'Notes: 3'

    page.accept_confirm do
      click_link 'Delete'
    end
    expect(page).not_to have_css '.assignments li', text: 'Assignment 1'
  end
end
