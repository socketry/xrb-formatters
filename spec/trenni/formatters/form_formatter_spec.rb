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
		let(:formatter) {FormFormatter.new(:object => double(:bar => 10))}
		
		it "should generate form" do
			result = formatter.input(:field => :bar)
			expect(result).to be == %Q{<dt>Bar</dt>\n<dd><input name="bar" value="10"/></dd>}
		end
		
		it "should have default value" do
			expect(formatter.value_for(:value => 10)).to be == "10"
			expect(formatter.value_for(:value => nil, :default => 10)).to be == "10"
		end
		
		it "should have a different title" do
			result = formatter.input(:field => :bar, :title => "Title")
			expect(result).to be == %Q{<dt>Title</dt>\n<dd><input name="bar" value="10"/></dd>}
		end
	end
	
	describe "<input>" do
		let(:formatter) {FormFormatter.new(:object => double(bar: 10, bob: true, dole: false))}
		
		it "should support support min, max and step" do
			attributes = formatter.input_attributes_for(:min => 10, :max => 20, :step => 2)
			
			expect(attributes[:min]).to be == 10
			expect(attributes[:max]).to be == 20
			expect(attributes[:step]).to be == 2
			
			result = formatter.input(:field => :bar, :min => 10)
			expect(result).to be == %Q{<dt>Bar</dt>\n<dd><input name="bar" value="10" min="10"/></dd>}
		end
		
		it "should not specify required, readonly or disabled" do
			attributes = formatter.input_attributes_for(:field => :bar)
			expect(attributes[:required]).to be nil
			expect(attributes[:readonly]).to be nil
			expect(attributes[:disabled]).to be nil
		end
		
		it "should specify required, readonly or disabled" do
			attributes = formatter.input_attributes_for(:field => :bar, :required => true, :readonly => true, :disabled => true)
			expect(attributes[:required]).to be true
			expect(attributes[:readonly]).to be true
			expect(attributes[:disabled]).to be true
		end
		
		it "should generate checked checkbox" do
			attributes = formatter.checkbox_attributes_for(:value => true)
			expect(attributes[:checked]).to be true
			
			result = formatter.checkbox(:field => :bob)
			expect(result).to be == %Q{<dd>\n\t<input type="hidden" name="bob" value="false"/>\n\t<label><input type="checkbox" name="bob" value="true" checked/> Bob</label>\n</dd>}
		end
		
		it "should generate unchecked checkbox" do
			attributes = formatter.checkbox_attributes_for(:value => false)
			expect(attributes[:checked]).to be nil
			
			result = formatter.checkbox(:field => :dole)
			expect(result).to be == %Q{<dd>\n\t<input type="hidden" name="dole" value="false"/>\n\t<label><input type="checkbox" name="dole" value="true"/> Dole</label>\n</dd>}
		end
	end
	
	describe "<textarea>" do
		let(:formatter) {FormFormatter.new(:object => double(details: "foo<bar>"))}
		
		it "should escape characters correctly" do
			result = formatter.textarea(:field => :details)
			expect(result).to be == %Q{<dt>\n\tDetails\n</dt>\n<dd><textarea name=\"details\">foo&lt;bar&gt;</textarea></dd>}
		end
	end
	
	describe '<input type="submit">' do
		let(:new_record_formatter) {FormFormatter.new(:object => double(new_record?: true))}
		let(:formatter) {FormFormatter.new(:object => double(new_record?: false))}
		
		it "should escape characters correctly" do
			result = formatter.submit
			expect(result).to be == %Q{<input type="submit" value="Update"/>}
		end
	end
	
	describe "<output>" do
		let(:formatter) {FormFormatter.new(:object => double(bar: 10, bob: true, dole: false))}
		
		it "should show output value" do
			result = formatter.output(:field => :bar)
			expect(result).to be == %Q{<dt>Bar</dt>\n<dd><output name=\"bar\">10</output></dd>}
		end
		
		it "should show output value" do
			result = formatter.output(:name => :total)
			expect(result).to be == %Q{<dt></dt>\n<dd><output name=\"total\"></output></dd>}
		end
	end
end
