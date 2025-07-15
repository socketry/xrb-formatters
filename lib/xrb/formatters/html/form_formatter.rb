# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2014-2024, by Samuel Williams.

require 'xrb/builder'

module XRB
	module Formatters
		module HTML
			module FormFormatter
				# Return true if the object is begin created or false if it is being updated.
				def new_record?
					object.nil? or object.new_record?
				end
				
				# Any additional details relating to a field (e.g. explanation text)
				def details_for(**options)
					options[:details]
				end
				
				def field_for(**options)
					options[:field]
				end
				
				# A title is a text string that will be displayed next to or on top of the control to describe it or its value:
				def title_for(**options)
					if title = options[:title]
						return title
					end
					
					# Generate a title from a field name:
					if field_name = field_for(**options)
						# Remove postfix "_id" or "_ids":
						return Strings::to_title(field_name.to_s.sub(/_ids?/, ''))
					end
				end

				def object_value_for(**options)
					if object = options[:object] and field = field_for(**options)
						object.send(field)
					end
				end

				def raw_value_for(**options)
					value = options.fetch(:value) {object_value_for(**options)}
					
					# Allow to specify a default value if the value given, usually from an object, is nil.
					value || options[:default]
				end

				# The value of the field.
				def value_for(**options)
					if value = raw_value_for(**options)
						self.format(value, **options)
					end
				end

				def pattern_for(**options)
					options[:pattern]
				end

				def placeholder_for(**options)
					options[:placeholder]
				end

				def input_attributes_for(**options)
					attributes = {
						:type => options[:type],
						:name => name_for(**options),
						:id => options[:id],
						:class => options[:class],
						:value => value_for(**options),
						:required => options[:required],
						:disabled => options[:disabled],
						:readonly => options[:readonly],
						:pattern => pattern_for(**options),
						:placeholder => placeholder_for(**options),
						# for <input type="range|number">
						:min => options[:minimum] || options[:min],
						:max => options[:maximum] || options[:max],
						:step => options[:step],
						# for <input type="text">
						:minlength => options[:minimum] || options[:minlength],
						:maxlength => options[:maximum] || options[:maxlength],
						:data => options[:data],
					}
					
					return attributes
				end

				def output_attributes_for(**options)
					attributes = {
						:name => name_for(**options),
						:id => options[:id],
						:class => options[:class],
						:for => options[:for],
						:form => options[:form],
						:data => options[:data],
					}
					
					return attributes
				end

				def textarea_attributes_for(**options)
					return {
						:name => name_for(**options),
						:id => options[:id],
						:class => options[:class],
						:required => options[:required],
						:disabled => options[:disabled],
						:readonly => options[:readonly],
						:pattern => pattern_for(**options),
						:placeholder => placeholder_for(**options),
						:minlength => options[:minlength],
						:maxlength => options[:maxlength],
						:data => options[:data],
					}
				end

				def checkbox_attributes_for(**options)
					return {
						:type => options[:type] || 'checkbox',
						:id => options[:id],
						:class => options[:class],
						:name => name_for(**options),
						:value => 'true',
						:checked => raw_value_for(**options),
						:required => options[:required],
						:disabled => options[:disabled],
						:readonly => options[:readonly],
						:data => options[:data],
					}
				end

				def submit_attributes_for(**options)
					return {
						:type => options[:type] || 'submit',
						:name => name_for(**options),
						:id => options[:id],
						:class => options[:class],
						:disabled => options[:disabled],
						:value => title_for(**options),
						:data => options[:data],
					}
				end
				
				def submit_title_for(**options)
					title_for(**options) || (new_record? ? 'Create' : 'Update')
				end
				
				def hidden_attributes_for(**options)
					return {
						:type => options[:type] || 'hidden',
						:id => options[:id],
						:class => options[:class],
						:name => name_for(**options),
						:value => value_for(**options),
						:data => options[:data],
					}
				end

				# A hidden field.
				def hidden(**options)
					options = @options.merge(**options)

					Builder.fragment do |builder|
						builder.tag :input, hidden_attributes_for(**options)
					end
				end
				
				def button_attributes_for(**options)
					return {
						:type => options[:type] || 'submit',
						:name => name_for(**options),
						:id => options[:id],
						:class => options[:class],
						:disabled => options[:disabled],
						:value => value_for(**options),
						:data => options[:data],
					}
				end
				
				def button_title_for(**options)
					type = options.fetch(:type, 'submit').to_sym
					
					if type == :submit
						submit_title_for(**options)
					else
						title_for(**options) || Strings::to_title(type.to_s)
					end
				end
				
				# A hidden field.
				def button(**options)
					options = @options.merge(**options)

					Builder.fragment do |builder|
						builder.inline :button, button_attributes_for(**options) do
							builder.text button_title_for(**options)
						end
					end
				end
				
				def fieldset(**options, &block)
					options = @options.merge(**options)
					buffer = XRB::Template.buffer(block.binding)
					
					Builder.fragment(buffer) do |builder|
						builder.tag('fieldset') do
							builder.inline('legend') do
								builder.text title_for(**options)
							end
							
							yield(builder)
						end
					end
				end
			end
		end
	end
end
