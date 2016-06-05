require 'rails_helper'

feature 'User Visits Homepage' do
  scenario 'successfully' do
    visit '/'

    expect(page).to have_css 'h2', text: 'Sign in'
  end
end
