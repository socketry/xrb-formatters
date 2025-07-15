# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2012-2025, by Samuel Williams.

require "xrb/builder"
require "xrb/template"

require_relative "form_formatter"

module XRB
	module Formatters
		module HTML
			module DefinitionListForm
				include FormFormatter
				
				# An input field (single line text).
				def input(**options)
					options = @options.merge(**options)
					
					Builder.fragment do |builder|
						builder.inline(:dt) do
							builder.text title_for(**options)
						end
						
						builder.inline(:dd) do
							builder.tag :input, input_attributes_for(**options)
							
							if details = details_for(**options)
								builder.inline(:small, class: "details") {builder.text details}
							end
						end
					end
				end
				
				# An output field for the result of a computation.
				def output(**options)
					options = @options.merge(**options)

					Builder.fragment do |builder|
						builder.inline(:dt) {builder.text title_for(**options)}

						builder.inline(:dd) do
							builder.inline :output, output_attributes_for(**options) do
								builder.text value_for(**options)
							end
						end
					end
				end
				
				# A textarea field (multi-line text).
				def textarea(**options)
					options = @options.merge(**options)

					Builder.fragment do |builder|
						builder.tag(:dt) do
							builder.text title_for(**options)
								
							if details = details_for(**options)
								builder.inline(:small, class: "details") {builder.text details}
							end
						end
						
						builder.inline(:dd) do
							builder.tag :textarea, textarea_attributes_for(**options) do
								builder.text value_for(**options)
							end
						end
					end
				end
				
				# A checkbox field.
				def checkbox(**options)
					options = @options.merge(**options)
					
					Builder.fragment do |builder|
						builder.tag(:dd) do
							builder.tag :input, :type => :hidden, :name => name_for(**options), :value => "false"
							
							builder.inline(:label) do
								builder.tag :input, checkbox_attributes_for(**options)
								# We would like a little bit of whitespace between the checkbox and the title.
								builder.text " " + title_for(**options)
							end
							
							if details = details_for(**options)
								builder.inline(:small, class: "details") {builder.text details}
							end
						end
					end
				end
				
				# A submission button
				def submit(**options)
					options = @options.merge(**options)
					options[:title] ||= submit_title_for(**options)
					
					Builder.fragment do |builder|
						builder.tag :input, submit_attributes_for(**options)
					end
				end
				
				def element(klass, **options, &block)
					options = @options.merge(**options)
					
					Builder.fragment(block&.binding) do |builder|
						builder.inline(:dt) do
							builder.text title_for(**options)
						end
						
						builder.tag(:dd) do
							klass.call(self, builder, **options, &block)
							
							if details = details_for(**options)
								builder.inline(:small, class: "details") {builder.text details}
							end
						end
					end
				end
				
				def fieldset(**options, &block)
					super do |builder|
						builder.tag(:dl) do
							yield(builder)
						end
					end
				end
			end
		end
	end
end
