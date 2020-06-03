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
			# Table based select boxes using per-row checkboxes.
			class RadioSelect
				def self.call(formatter, builder, **options, &block)
					instance = self.new(formatter, builder, **options)
					
					instance.call(options, &block)
				end
				
				def initialize(formatter, builder, **options)
					@formatter = formatter
					@object = formatter.object
					
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

				def item(builder: nil, **options, &block)
					Builder.fragment(builder) do |builder|
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
					end >> block
				end

				def optional_title_for(**options)
					if options[:optional] == true
						options[:blank] || ''
					else
						options[:optional]
					end
				end

				def call(options = {}, &block)
					Builder.fragment(@builder) do |builder|
						builder.tag :table do
							builder.tag :tbody do
								if options[:optional]
									item(:title => optional_title_for(**options), :value => nil, :builder => builder)
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
