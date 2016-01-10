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
require 'trenni/template'

require_relative 'form_formatter'

module Trenni
	module Formatters
		module HTML
			module DefinitionListForm
				include FormFormatter
				
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

				# An output field for the result of a computation.
				def output(options = {})
					options = @options.merge(options)

					Builder.fragment do |builder|
						builder.inline(:dt) { builder.text title_for(options) }

						builder.inline(:dd) do
							builder.tag :output, output_attributes_for(options)
						end
					end
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

				# A submission button
				def submit(options = {})
					options = @options.merge(options)
					
					if title = title_for(options)
						options[:title] = title
					else
						options[:title] ||= new_record? ? 'Create' : 'Update'
					end

					Builder.fragment do |builder|
						builder.tag :input, submit_attributes_for(options)
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
