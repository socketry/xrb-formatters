
require 'trenni/builder'

module Trenni
	module Formatters
		module HTML
			module DefinitionListForm
				# The target object of the form.
				def object
					@options[:object]
				end

				# The name of the field.
				def name_for(options)
					options[:field] || title_for(options).downcase.gsub(/\s+/, '_').to_sym
				end

				# The human presentable title for the field.
				def title_for(options)
					title = options[:title] || Strings::to_title(options[:field].to_s)
					
					Strings::to_html(title)
				end

				# The value of the field.
				def value_for(options)
					value = options[:value]

					if options[:object]
						value ||= options[:object].send(name_for(options))
					end

					self.format(value, options)
				end

				def pattern_for(options)
					nil
				end

				def input_attributes_for(options)
					return {
							:type => options[:type],
							:name => name_for(options),
							:value => value_for(options),
							:required => options[:required] ? true : false,
							:pattern => pattern_for(options)
					}
				end

				# An input field (single line text).
				def input(options = {})
					options = @options.merge(options)

					Builder.fragment do |builder|
						builder.inline(:dt) { builder.text title_for(options) }

						builder.inline(:dd) do
							builder.tag :input, input_attributes_for(options)
						end
					end
				end

				def textarea_attributes_for(options)
					return {
						:name => name_for(options),
						:required => options[:required] ? true : false,
					}
				end

				# A textarea field (multi-line text).
				def textarea(options = {})
					options = @options.merge(options)

					Builder.fragment do |builder|
						builder.inline(:dt) { builder.text title_for(options) }

						builder.inline(:dd) do
							builder.tag :textarea, textarea_attributes_for(options) do
								builder.text value_for(options)
							end
						end
					end
				end

				def checkbox_attributes_for(options)
					return {
						:type => options[:type] || 'checkbox',
						:checked => options[:object].send(name),
						:name => name_for(options),
						:required => options[:required] ? true : false,
						:value => 'true',
					}
				end

				# A checkbox field.
				def checkbox(options)
					options = @options.merge(options)

					Builder.fragment do |builder|
						builder.tag(:dd) do
							builder.tag :input, :type => :hidden, :name => name_for(options), :value => 'false'
							builder.tag :input, checkbox_attributes_for(options)
							builder.text " " + title_for(options)
						end
					end
				end

				def submit_attributes_for(options)
					return {
						:type => options[:type] || 'submit',
						:name => name_for(options),
						:value => title_for(options),
					}
				end

				# A submission button
				def submit(options = {})
					options = @options.merge(options)

					unless options[:field]
						options[:title] ||= self.object.saved? ? 'Update' : 'Create'
					end

					Builder.fragment do |builder|
						builder.tag :input, submit_attributes_for(options)
					end
				end

				def hidden_attributes_for(options)
					return {
						:type => options[:type] || 'hidden',
						:name => name_for(options),
						:value => value_for(options),
					}
				end

				# A hidden field.
				def hidden(options = {})
					options = @options.merge(options)

					Builder.fragment do |builder|
						builder.tag :input, hidden_attributes_for(options)
					end
				end

				def element(klass, options = {}, &block)
					options = @options.merge(options)
					buffer = Trenni::Template.buffer(block.binding)
					
					buffer << Builder.fragment do |builder|
						builder.inline(:dt) { builder.text title_for(options) }
						builder.tag(:dd) do
							klass.call(self, options, builder, &block)
						end
					end
				end
			end
		end
	end
end
