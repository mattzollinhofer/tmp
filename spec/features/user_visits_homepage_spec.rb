require 'rails_helper'

feature 'User Visits Homepage' do
  scenario 'successfully' do
    visit '/'

    expect(page).to have_css '.h1', text: 'Sign In!!'
    expect(page).to have_css 'a', text: 'With Gmail'
  end
end
