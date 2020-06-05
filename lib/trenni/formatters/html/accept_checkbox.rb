# frozen_string_literal: true

# Copyright, 2020, by Samuel G. D. Williams. <http://www.codeotaku.com>
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
			class AcceptCheckbox
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
				
				def title_for(**options)
					@formatter.title_for(**options)
				end
				
				def checkbox_attributes_for(**options)
					@formatter.checkbox_attributes_for(**options)
				end
				
				def call(**options, &block)
					Builder.fragment(@builder) do |builder|
						builder.inline('span') do
							builder.inline :input, :type => :hidden, :name => name_for(**options), :value => 'false'
							
							builder.tag :input, checkbox_attributes_for(**options)
							
							builder.text " "
							
							builder.capture(self, &block)
						end
					end
				end
			end
		end
	end
end
