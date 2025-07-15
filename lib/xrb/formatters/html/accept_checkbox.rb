# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2020-2025, by Samuel Williams.

require "xrb/builder"

module XRB
	module Formatters
		module HTML
			class AcceptCheckbox
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
					@formatter.name_for(**options)
				end
				
				def checkbox_attributes_for(**options)
					@formatter.checkbox_attributes_for(**options)
				end
				
				def call(&block)
					Builder.fragment(@builder) do |builder|
						builder.inline("span") do
							builder.inline :input, type: :hidden, name: name_for(**@options), value: "false"
							
							builder.tag :input, checkbox_attributes_for(**@options)
							
							builder.text " "
							
							builder.capture(self, &block)
						end
					end
				end
			end
		end
	end
end
