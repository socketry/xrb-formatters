
require_relative "lib/trenni/formatters/version"

Gem::Specification.new do |spec|
	spec.name = "trenni-formatters"
	spec.version = Trenni::Formatters::VERSION
	
	spec.summary = "Formatters for Trenni, to assist with typical views and form based interfaces."
	spec.authors = ["Samuel Williams"]
	spec.license = "MIT"
	
	spec.homepage = "https://github.com/ioquatix/trenni-formatters"
	
	spec.metadata = {
		"funding_uri" => "https://github.com/sponsors/ioquatix/",
	}
	
	spec.files = Dir.glob('{lib}/**/*', File::FNM_DOTMATCH, base: __dir__)

	spec.required_ruby_version = ">= 2.5"
	
	spec.add_dependency "mapping", "~> 1.1"
	spec.add_dependency "trenni", "~> 3.4"
	
	spec.add_development_dependency "bake"
	spec.add_development_dependency "bake-bundler"
	spec.add_development_dependency "bake-modernize"
	spec.add_development_dependency "bundler"
	spec.add_development_dependency "covered"
	spec.add_development_dependency "rspec"
end
