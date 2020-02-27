
require_relative 'lib/trenni/formatters/version'

Gem::Specification.new do |spec|
	spec.name = "trenni-formatters"
	spec.version = Trenni::Formatters::VERSION
	spec.authors = ["Samuel Williams"]
	spec.email = ["samuel.williams@oriontransfer.co.nz"]
	spec.description = <<-EOF
	Trenni is a templating system, and these formatters assist with the development
	of typical view and form based web interface. A formatter is a high-level
	adapter that turns model data into presentation text.

	Formatters are designed to be customised, typically per-project, for specific
	formatting needs.
	EOF
	spec.summary = %q{Formatters for Trenni, to assist with typical views and form based interfaces.}
	spec.homepage = "https://github.com/ioquatix/trenni-formatters"

	spec.files = `git ls-files`.split($/)
	spec.test_files = spec.files.grep(%r{^(test|spec|features)/})
	spec.require_paths = ["lib"]
	
	spec.add_dependency "trenni", "~> 3.4"
	spec.add_dependency "mapping", "~> 1.1"
	
	spec.add_dependency "trenni-sanitize"
	
	spec.add_development_dependency "covered"
	spec.add_development_dependency "bundler"
	spec.add_development_dependency "rspec"
	spec.add_development_dependency "rake"
end
