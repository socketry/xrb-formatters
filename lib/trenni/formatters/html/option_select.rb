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
				def self.call(formatter, options, builder, &block)
					instance = self.new(formatter, options, builder)
					
					instance.call(options, &block)
				end
				
				def initialize(formatter, options, builder)
					@formatter = formatter
					@object = formatter.object
					@field = options[:field]
					
					@builder = builder
				end

				def name_for(options)
					@formatter.name_for(options)
				end

				def value_for(options)
					@formatter.value_for(options)
				end

				def title_for(options)
					@formatter.title_for(options)
				end

				def option_attributes_for(options)
					return {
						:value => value_for(options),
						:selected => options[:selected],
					}
				end

				def item(options = {})
					options[:field] ||= 'id'
					
					Builder.fragment(options[:builder]) do |builder|
						builder.inline(:option, option_attributes_for(options)) { builder.text title_for(options) }
					end
				end

				def group_attributes_for(options)
					return {
						:label => title_for(options)
					}
				end

				def group(options = {}, &block)
					Builder.fragment do |builder|
						builder.tag :optgroup, group_attributes_for(options) do
							if options[:optional]
								item(:title => '', :value => '', :builder => builder)
							end
							
							builder.append Trenni::Template.capture(&block)
						end
					end
				end

				def select_attributes_for(options)
					return {
						:name => name_for(options)
					}
				end

				def call(options = {}, &block)
					Builder.fragment(@builder) do |builder|
						builder.tag :select, select_attributes_for(options) do
							if options[:optional]
								item(:title => '', :value => '', :builder => builder)
							end
							
							builder.append Trenni::Template.capture(self, &block)
						end
					end
				end
			end
		end
	end
end
