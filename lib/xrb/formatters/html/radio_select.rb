# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2012-2025, by Samuel Williams.

require "xrb/builder"

module XRB
	module Formatters
		module HTML
			# Table based select boxes using per-row checkboxes.
			class RadioSelect
				def self.call(formatter, builder, **options, &block)
					instance = self.new(formatter, builder, **options)
					
					instance.call(&block)
				end
				
				def initialize(formatter, builder, **options)
					@formatter = formatter
					@builder = builder
					@options = options
					
					@field = options[:field]
				end
				
				def name_for(**options)
					@formatter.name_for(**options)
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
				
				def radio_attributes_for(**options)
					return {
						:type => :radio,
						:name => @field,
						# We set a default value to empty string, otherwise it becomes "on".
						:value => value_for(**options) || "",
						:checked => options.fetch(:selected) {raw_value == raw_value_for(**options)},
						:data => options[:data],
					}
				end
				
				def item(**options, &block)
					Builder.fragment(block&.binding || @builder) do |builder|
						builder.tag :tr do
							builder.inline(:td, :class => :handle) do
								builder.tag :input, radio_attributes_for(**options)
							end
							
							builder.inline(:td, :class => :item) do
								if block_given?
									builder.capture(self, &block)
								else
									builder.text title_for(**options)
								end
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
				
				def optional?
					@options[:optional]
				end
				
				def call(&block)
					Builder.fragment(@builder) do |builder|
						builder.tag :table do
							builder.tag :tbody do
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
end
