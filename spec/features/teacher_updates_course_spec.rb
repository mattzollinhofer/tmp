feature 'Teacher updates course' do
  scenario 'successfully' do
    teacher = FactoryGirl.create(:teacher)
    course  = FactoryGirl.create(:course, teachers: [teacher])

    login_as(teacher, scope: :user)

    visit root_path
    expect(page).to have_css 'li', text: course.name
    click_on 'edit'
    fill_in 'course[name]', with: 'Course Name Foo'
    click_on 'Update Course'

    expect(page).to have_css '.courses li', text: 'Course Name Foo'
  end

  scenario 'unsuccessfully' do
    teacher = FactoryGirl.create(:teacher)
    course  = FactoryGirl.create(:course, teachers: [teacher])

    login_as(teacher, scope: :user)

    visit root_path
    expect(page).to have_css 'li', text: course.name
    click_on 'edit'
    fill_in 'course[name]', with: ''
    click_on 'Update Course'

    expect(page).to have_css '#course_name_input.error .inline-errors', text: "can't be blank"
  end
end
