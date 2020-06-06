# frozen_string_literal: true

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
				
				def item(builder = nil, **options)
					options[:field] ||= 'id'
					
					Builder.fragment(builder) do |builder|
						builder.inline(:option, option_attributes_for(**options)) {builder.text title_for(**options)}
					end
				end
				
				def optional_title_for(**options)
					if options[:optional] == true
						options[:blank] || ''
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
					Builder.fragment(@builder) do |builder|
						builder.tag :optgroup, group_attributes_for(**options) do
							if options[:optional]
								item(@builder, title: optional_title_for(**options), value: nil)
							end
							
							builder.capture(&block)
						end
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
								item(builder, title: optional_title_for(**@options), value: nil)
							end
							
							builder.capture(self, &block)
						end
					end
				end
			end
		end
	end
end
