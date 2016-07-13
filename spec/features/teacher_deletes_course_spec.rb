feature 'Teacher deletes a course', js: true do
  scenario 'successfully' do
    teacher = FactoryGirl.create(:teacher)
    course  = FactoryGirl.create(:course)

    login_as(teacher, scope: :user)

    visit root_path
    expect(page).to have_css 'li', text: course.name

    page.dismiss_confirm do
      click_link 'delete'
    end
    expect(page).to have_css '.courses li', text: course.name

    page.accept_confirm do
      click_link 'delete'
    end
    expect(page).not_to have_css '.courses li', text: course.name
  end
end
