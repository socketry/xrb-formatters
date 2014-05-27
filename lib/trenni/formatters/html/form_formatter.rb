# Copyright, 2012, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'trenni/builder'

module Trenni
	module Formatters
		module HTML
			module FormFormatter
				# The target object of the form.
				def object
					@options[:object]
				end

				# The name of the field, used for the name attribute of an input.
				def name_for(options)
					options[:name] || options[:field]
				end
				
				def field_for(options)
					options[:field]
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
						value ||= options[:object].send(field_for(options))
					end

					# Allow to specify a default value if the value given, usually from an object, is nil.
					value ||= options[:default]

					self.format(value, options)
				end

				def pattern_for(options)
					options[:pattern]
				end

				def placeholder_for(options)
					options[:placeholder]
				end

				def input_attributes_for(options)
					attributes = {
						:type => options[:type],
						:name => name_for(options),
						:value => value_for(options),
						:required => options[:required] ? true : false,
						:pattern => pattern_for(options),
						:placeholder => placeholder_for(options),
						# for <input type="range|number">
						:min => options[:min],
						:max => options[:max],
						:step => options[:step],
					}
					
					if explicit_attributes = options[:attributes]
						attributes.update(explicit_attributes)
					end
					
					return attributes
				end

				def textarea_attributes_for(options)
					return {
						:name => name_for(options),
						:required => options[:required] ? true : false,
						:placeholder => placeholder_for(options),
					}
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

				def submit_attributes_for(options)
					return {
						:type => options[:type] || 'submit',
						:name => name_for(options),
						:value => title_for(options),
					}
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
			end
		end
	end
end
