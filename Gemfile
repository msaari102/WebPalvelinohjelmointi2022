source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

gem "rails", "~> 7.0.3"

gem "sprockets-rails"

group :development, :test do
  gem 'sqlite3'
end

group :production do
   gem 'pg'
end

gem 'httparty'

gem 'bcrypt', '~> 3.1.7'

gem "puma", "~> 5.0"

gem "importmap-rails"

gem "turbo-rails"

gem "stimulus-rails"

gem "jbuilder"

gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

gem "bootsnap", require: false

group :development, :test do
  gem 'pry-byebug'
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  gem "web-console"
end

group :test do
  gem 'rspec-rails', '~> 6.0.0.rc1'
  gem 'factory_bot_rails'
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
  gem 'simplecov', require: false
  gem 'webmock'
end