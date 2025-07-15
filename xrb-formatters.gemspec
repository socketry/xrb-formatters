# frozen_string_literal: true

require_relative "lib/xrb/formatters/version"

Gem::Specification.new do |spec|
	spec.name = "xrb-formatters"
	spec.version = XRB::Formatters::VERSION
	
	spec.summary = "Formatters for XRB, to assist with typical views and form based interfaces."
	spec.authors = ["Samuel Williams"]
	spec.license = "MIT"
	
	spec.cert_chain  = ["release.cert"]
	spec.signing_key = File.expand_path("~/.gem/release.pem")
	
	spec.homepage = "https://github.com/ioquatix/xrb-formatters"
	
	spec.metadata = {
		"funding_uri" => "https://github.com/sponsors/ioquatix/",
		"source_code_uri" => "https://github.com/ioquatix/xrb-formatters.git",
	}
	
	spec.files = Dir.glob(["{lib}/**/*", "*.md"], File::FNM_DOTMATCH, base: __dir__)
	
	spec.required_ruby_version = ">= 3.2"
	
	spec.add_dependency "mapping", "~> 1.1"
	spec.add_dependency "xrb", "~> 0.6"
end
