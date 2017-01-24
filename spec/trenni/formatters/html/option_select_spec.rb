# Copyright, 2014, by Samuel G. D. Williams. <http://www.codeotaku.com>
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

module Trenni::Formatters::HTML::OptionSelectSpec
	class FormFormatter < Trenni::Formatters::Formatter
		include Trenni::Formatters::HTML::DefinitionListForm
		
		def select(options = {}, &block)
			element(Trenni::Formatters::HTML::OptionSelect, options, &block)
		end
	end
	
	def capture(&block)
		_out = ""
		
		Trenni::Template.capture do
			formatter.select :field => :bar do |select|
				_out << select.item(:title => "A", :value => 0)
				_out << select.item(:title => "B", :value => 10)
			end
		end
	end
	
	describe Trenni::Formatters::HTML::OptionSelect do
		let(:formatter) {FormFormatter.new(:object => double(:bar => 10))}
		
		it "should list items" do
			_out = ""
			
			captured = Trenni::Template.capture do
				formatter.select :field => :bar do |select|
					_out << select.item(:title => "A", :value => 0)
					_out << select.item(:title => "B", :value => 10)
				end
			end
			
			expect(captured).to be == "<dt>Bar</dt>\n<dd>\n\t<select name=\"bar\">\n\t\t<option value=\"0\">A</option><option value=\"10\" selected>B</option>\n\t</select>\n</dd>"
		end
		
		it "should list items with data attributes" do
			_out = ""
			
			captured = Trenni::Template.capture do
				formatter.select :field => :bar do |select|
					_out << select.item(:title => "A", :value => 0, :data => {foo: 'bar'})
				end
			end
			
			expect(captured).to be == "<dt>Bar</dt>\n<dd>\n\t<select name=\"bar\">\n\t\t<option value=\"0\" data-foo=\"bar\">A</option>\n\t</select>\n</dd>"
		end
		
		it "should list items for multiple selection" do
			_out = ""
			
			captured = Trenni::Template.capture do
				formatter.select :field => :bar, multiple: true do |select|
					_out << select.item(:title => "A", :value => 0)
					_out << select.item(:title => "B", :value => 10)
				end
			end
			
			expect(captured).to be == "<dt>Bar</dt>\n<dd>\n\t<select name=\"bar[]\" multiple>\n\t\t<option value=\"0\">A</option><option value=\"10\" selected>B</option>\n\t</select>\n</dd>"
		end
		
		it "should add optional item" do
			_out = ""
			
			captured = Trenni::Template.capture do
				formatter.select :field => :bar, optional: true do |select|
					_out << select.item(:title => "A", :value => 0)
					_out << select.item(:title => "B", :value => 10)
				end
			end
			
			expect(captured).to be == "<dt>Bar</dt>\n<dd>\n\t<select name=\"bar\">\n\t\t<option></option>\t\t<option value=\"0\">A</option><option value=\"10\" selected>B</option>\n\t</select>\n</dd>"
		end
		
		it "should add optional item in group" do
			_out = ""
			
			captured = Trenni::Template.capture do
				formatter.select :field => :bar do |select|
					select.group(title: 'group', optional: true) do
						_out << select.item(:title => "A", :value => 0)
					end
					_out << select.item(:title => "B", :value => 10)
				end
			end
			
			expect(captured).to be == "<dt>Bar</dt>\n<dd>\n\t<select name=\"bar\">\n\t\t<optgroup label=\"group\">\n\t\t\t<option></option>\t\t\t<option value=\"0\">A</option>\n\t\t</optgroup>\t\t<option value=\"10\" selected>B</option>\n\t</select>\n</dd>"
		end
		
		it "should add a group" do
			_out = ""
			
			captured = Trenni::Template.capture do
				formatter.select :field => :bar do |select|
					select.group(title: 'group') do
						_out << select.item(:title => "A", :value => 0)
					end
					_out << select.item(:title => "B", :value => 10)
				end
			end
			
			expect(captured).to be == "<dt>Bar</dt>\n<dd>\n\t<select name=\"bar\">\n\t\t<optgroup label=\"group\">\n\t\t\t<option value=\"0\">A</option>\n\t\t</optgroup>\t\t<option value=\"10\" selected>B</option>\n\t</select>\n</dd>"
		end
	end
end
