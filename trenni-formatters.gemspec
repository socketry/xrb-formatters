# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'trenni/formatters/version'

Gem::Specification.new do |gem|
	gem.name          = "trenni-formatters"
	gem.version       = Trenni::Formatters::VERSION
	gem.authors       = ["Samuel Williams"]
	gem.email         = ["samuel.williams@oriontransfer.co.nz"]
	gem.description   = <<-EOF
	Trenni is a templating system, and these formatters assist with the development
	of typical view and form based web interface. A formatter is a high-level
	adapter that turns model data into presentation text.

	Formatters are designed to be customised, typically per-project, for specific
	formatting needs.
	EOF
	gem.summary       = %q{Formatters for Trenni, to assist with typical views and form based interfaces.}
	gem.homepage      = "https://github.com/ioquatix/trenni-formatters"

	gem.files         = `git ls-files`.split($/)
	gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
	gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
	gem.require_paths = ["lib"]
	
	gem.add_dependency "trenni", "~> 1.0.4"
end
