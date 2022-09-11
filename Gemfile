# frozen_string_literal: true

source 'https://rubygems.org'

ruby File.read('.ruby-version')

group :development do
  gem 'byebug'
end

group :development, :test do
  gem 'rubocop-rspec', require: false
  gem 'rubocop-shopify', require: false
end

group :test do
  gem 'rspec'
end
