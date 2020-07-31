# frozen_string_literal: true

source 'https://rubygems.org'

# Specify your gem's dependencies in trenni-formatters.gemspec
gemspec

group :maintenance, optional: true do
	gem 'bake-modernize'
	gem 'bake-bundler'
end

group :test do
	gem 'trenni-sanitize'
	gem 'markly'
end
