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

module Trenni::Formatters::FormFormatterSpec
	class FormFormatter < Trenni::Formatters::Formatter
		include Trenni::Formatters::HTML::DefinitionListForm
	end
	
	describe Trenni::Formatters do
		it "should generate form" do
			object = double(:bar => 10)
			
			formatter = FormFormatter.new(:object => object)
			
			output_tag = formatter.input(:field => :bar)
			expect(output_tag).to be == %Q{<dt>Bar</dt>\n<dd><input name="bar" value="10"/></dd>}
		end
		
		it "should have default value" do
			formatter = FormFormatter.new
			
			expect(formatter.value_for(:value => 10)).to be == "10"
			expect(formatter.value_for(:value => nil, :default => 10)).to be == "10"
		end
	end
	
	describe "<input>" do
		it "should support support min, max and step" do
			object = double(:bar => 10)
			
			formatter = FormFormatter.new(:object => object)
			
			attributes = formatter.input_attributes_for(:min => 10, :max => 20, :step => 2)
			
			expect(attributes[:min]).to be == 10
			expect(attributes[:max]).to be == 20
			expect(attributes[:step]).to be == 2
			
			output_tag = formatter.input(:field => :bar, :min => 10)
			expect(output_tag).to be == %Q{<dt>Bar</dt>\n<dd><input name="bar" value="10" min="10"/></dd>}
		end
	end
end