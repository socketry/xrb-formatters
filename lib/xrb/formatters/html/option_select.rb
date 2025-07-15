# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2012-2025, by Samuel Williams.

require "xrb/builder"

module XRB
	module Formatters
		module HTML
			# Standard drop-down select box:
			class OptionSelect
				def self.call(formatter, builder, **options, &block)
					instance = self.new(formatter, builder, **options)
					
					instance.call(&block)
				end
				
				def initialize(formatter, builder, **options)
					@formatter = formatter
					@builder = builder
					@options = options
				end
				
				def name_for(**options)
					if name = @formatter.name_for(**options)
						if options[:multiple]
							name = "#{name}[]"
						end
						
						return name
					end
				end
				
				def raw_value_for(**options)
					@formatter.raw_value_for(**options)
				end
				
				def raw_value
					@raw_value ||= raw_value_for(**@options)
				end
				
				def value_for(**options)
					@formatter.value_for(**options)
				end
				
				def title_for(**options)
					@formatter.title_for(**options)
				end
				
				def option_attributes_for(**options)
					return {
						:value => value_for(**options),
						:selected => options.fetch(:selected) {raw_value == raw_value_for(**options)},
						:id => options[:id],
						:class => options[:class],
						:data => options[:data],
					}
				end
				
				def item(**options, &block)
					options[:field] ||= "id"
					
					Builder.fragment(block&.binding || @builder) do |builder|
						builder.inline(:option, option_attributes_for(**options)) do
							if block_given?
								builder.capture(self, &block)
							else
								builder.text title_for(**options)
							end
						end
					end
				end
				
				def optional_title_for(**options)
					if options[:optional] == true
						options[:blank] || ""
					else
						options[:optional]
					end
				end
				
				def group_attributes_for(**options)
					return {
						:label => title_for(**options),
						:id => options[:id],
						:class => options[:class],
						:data => options[:data],
					}
				end
				
				def group(**options, &block)
					@builder.tag :optgroup, group_attributes_for(**options) do
						if options[:optional]
							item(title: optional_title_for(**options), value: nil)
						end
						
						@builder.capture(&block)
					end
				end
				
				def select_attributes_for(**options)
					return {
						:name => name_for(**options),
						:id => options[:id],
						:class => options[:class],
						:multiple => options[:multiple],
						:data => options[:data],
						:required => options[:required],
					}
				end
				
				def optional?
					@options[:optional]
				end
				
				def call(&block)
					Builder.fragment(@builder) do |builder|
						builder.tag :select, select_attributes_for(**@options) do
							if self.optional?
								builder << item(title: optional_title_for(**@options), value: nil)
							end
							
							builder.capture(self, &block)
						end
					end
				end
			end
		end
	end
end
