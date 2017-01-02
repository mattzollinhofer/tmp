source 'https://rubygems.org'

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap-chosen'
end

gem 'font-awesome-rails'

gem 'rails', '~> 4.2.7'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'

gem 'jquery-rails'
gem 'jquery-ui-sass-rails'
#gem 'turbolinks'
gem 'pg'

gem 'formtastic', '~> 3.0'
gem 'bootstrap-sass'
gem 'formtastic-bootstrap'
gem 'chosen-rails'

#Auth
gem 'devise'
gem 'omniauth-google-oauth2'

gem "skylight"
gem 'rollbar'

group :production do
  gem 'rails_12factor'
end

group :development, :test do
  gem 'capybara'
  gem 'poltergeist'
  gem 'byebug'
  gem 'rspec-rails', '~> 3.0'
  gem 'factory_girl_rails'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'launchy'
end

group :development do
  gem 'rack-mini-profiler'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'rubocop', require: false
  gem 'spring-commands-rspec'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

