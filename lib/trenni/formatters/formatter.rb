
require 'trenni/strings'

module Trenni
	module Formatters
		class Formatter
			def initialize(options = {})
				@options = options
				@formatters = {}
			end

			def format(object, options = {})
				if formatter = @formatters[object.class]
					@formatters[object.class].call(object, options)
				else
					if object
						Strings::to_html(object.to_s)
					else
						options[:blank] || ""
					end
				end
			end

			alias text format

			def [] key
				@options[key]
			end

			def for(klass, &block)
				@formatters[klass] = block
			end

			protected

			def merged_options(options = {})
				@options.merge(options)
			end
		end
	end
end
