
require 'trenni/builder'

module Trenni
	module Formatters
		module HTML
			# Standard drop-down select box:
			class OptionSelect
				def self.call(formatter, options, builder, &block)
					instance = self.new(formatter, options, builder)
					
					instance.call(options, &block)
				end
				
				def initialize(formatter, options, builder)
					@formatter = formatter
					@object = formatter.object
					@field = options[:field]
					
					@builder = builder
				end

				def name_for(options)
					@formatter.name_for(options)
				end

				def value_for(options)
					@formatter.value_for(options)
				end

				def title_for(options)
					@formatter.title_for(options)
				end

				def item_attributes_for(options)
					return {
						:value => value_for(options),
						:selected => options[:selected],
					}
				end

				def item(options = {})
					options[:field] ||= 'id'
					
					Builder.fragment(options[:builder]) do |builder|
						builder.inline(:option, option_attributes_for(options)) { builder.text title_for(options) }
					end
				end

				def group_attributes_for(options)
					return {
						:label => title_for(options)
					}
				end

				def group(options = {}, &block)
					Builder.fragment do |builder|
						builder.tag :optgroup, group_attributes_for(options) do
							if options[:optional]
								item(:title => '', :value => '', :builder => builder)
							end
							
							builder.append Trenni::Template.capture(&block)
						end
					end
				end

				def select_attributes_for(options)
					return {
						:name => name_for(options)
					}
				end

				def call(options = {}, &block)
					Builder.fragment(@builder) do |builder|
						builder.tag :select, select_attributes_for(options) do
							if options[:optional]
								item(:title => '', :value => '', :builder => builder)
							end
							
							builder.append Trenni::Template.capture(self, &block)
						end
					end
				end
			end
		end
	end
end
