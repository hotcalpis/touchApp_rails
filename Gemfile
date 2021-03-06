# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.2.4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use ActiveStorage variant
gem 'mini_magick', '~> 4.8'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

gem 'acts-as-taggable-on'
gem 'annotate'
gem 'aws-sdk-s3', require: false
gem 'aws-ses'
gem 'bootstrap'
gem 'cancancan'
gem 'devise'
gem 'haml-rails'
gem 'jquery-rails'
gem 'kaminari'
gem 'kaminari-bootstrap'
gem 'meta-tags'
gem 'mysql2'
gem 'omniauth-github'
gem 'rails-i18n'
gem 'rails_admin'
gem 'redcarpet'
gem 'rouge'
gem 'rubocop', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'bullet'
  gem 'spring'
  gem 'spring-commands-rspec'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'puma'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  # #ajaxテストの際に使用、qmakeコマンドなど環境構築が膨らんでしまう
  # gem 'capybara-webkit'
  # gem 'database_cleaner'
end

group :development, :production do
  gem 'unicorn'
end

group :production do
  gem 'omniauth-rails_csrf_protection'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
