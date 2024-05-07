# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2020-2024, by Samuel Williams.

require 'xrb/builder'
require 'xrb/template'

require_relative 'form_formatter'

module XRB
	module Formatters
		module HTML
			module LabelForm
				include FormFormatter
				
				# An input field (single line text).
				def input(**options)
					options = @options.merge(**options)
					
					Builder.fragment do |builder|
						builder.inline(:label) do
							builder.inline(:span) do
								builder.text title_for(**options)
								
								if details = details_for(**options)
									builder.inline(:small) {builder.text details}
								end
							end
							
							builder.inline :input, input_attributes_for(**options)
						end
					end
				end
				
				# An output field for the result of a computation.
				def output(**options)
					options = @options.merge(**options)
					
					builder.inline(:label) do
						builder.inline(:span) do
							builder.text title_for(**options)
							
							if details = details_for(**options)
								builder.inline(:small) {builder.text details}
							end
						end
						
						builder.inline :output, output_attributes_for(**options) do
							builder.text value_for(**options)
						end
					end
				end
				
				# A textarea field (multi-line text).
				def textarea(**options)
					options = @options.merge(**options)
					
					Builder.fragment do |builder|
						builder.inline(:label) do
							builder.inline(:span) do
								builder.text title_for(**options)
								
								if details = details_for(**options)
									builder.inline(:small) {builder.text details}
								end
							end
							
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
						builder.inline(:label) do
							builder.inline :input, :type => :hidden, :name => name_for(**options), :value => 'false'
							
							builder.inline(:span) do
								if details = details_for(**options)
									builder.inline(:small) {builder.text details}
								end
							end
							
							builder.tag :input, checkbox_attributes_for(**options)
							
							# We would like a little bit of whitespace between the checkbox and the title:
							builder.text " " + title_for(**options)
						end
					end
				end
				
				# A submission button
				def submit(**options)
					options = @options.merge(**options)
					options[:title] ||= submit_title_for(**options)
					
					Builder.fragment do |builder|
						builder.inline :input, submit_attributes_for(**options)
					end
				end
				
				def element(klass, **options, &block)
					options = @options.merge(**options)
					buffer = XRB::Template.buffer(block.binding)
					
					Builder.fragment(buffer) do |builder|
						builder.inline(:label) do
							builder.inline(:span) do
								builder.text title_for(**options)
								
								if details = details_for(**options)
									builder.inline(:small) {builder.text details}
								end
							end
							
							klass.call(self, builder, **options, &block)
						end
					end
				end
			end
		end
	end
end
