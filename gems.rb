# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in trenni-formatters.gemspec
gemspec

group :test do
	gem 'trenni-sanitize'
	gem 'markly'
end
