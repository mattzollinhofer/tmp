feature 'Teacher updates students assignment grade' do
  scenario 'successfully' do
    course  = FactoryBot.create(:course)
    teacher = FactoryBot.create(:teacher)

    login_as(teacher, scope: :user)

    visit courses_path
    expect(page).to have_css 'li', text: course.name
    click_on 'edit'
    fill_in 'course[name]', with: 'Course Name Foo'
    fill_in 'course[year]', with: '2000'
    click_on 'Update Course'

    expect(page).to have_css '.courses li', text: 'Course Name Foo'
  end

  scenario 'unsuccessfully' do
    course  = FactoryBot.create(:course)
    teacher = FactoryBot.create(:teacher)
    class_period = FactoryBot.create(:class_period, teachers: [teacher], course: course)

    login_as(teacher, scope: :user)

    visit courses_path
    expect(page).to have_css 'li', text: course.name
    click_on 'edit'
    fill_in 'course[name]', with: ''
    fill_in 'course[year]', with: ''
    click_on 'Update Course'

    expect(page).to have_css '#course_name_input.error .inline-errors', text: "can't be blank"
  end
end
