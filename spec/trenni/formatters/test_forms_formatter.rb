#!/usr/bin/env ruby

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

require 'trenni/formatters'
require 'trenni/formatters/html/definition_list_form'
require 'trenni/formatters/html/option_select'
require 'trenni/formatters/html/table_select'

module Trenni
	module Formatters
		module FormFormattersSpec
			class FormFormatter < Trenni::Formatters::Formatter
				include Trenni::Formatters::HTML::DefinitionListForm
			end
			
			describe Formatters do
				it "should generate form" do
					object = double(:bar => 10)
					
					formatter = FormFormatter.new(:object => object)
					
					expect(formatter.input(:field => :bar)).to be == %Q{<dt>Bar</dt>\n<dd><input name="bar" value="10"/></dd>}
				end
			end
		end
	end
end
