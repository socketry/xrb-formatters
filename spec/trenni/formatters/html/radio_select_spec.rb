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
require 'trenni/formatters/html/radio_select'

module Trenni::Formatters::HTML::RadioSelectSpec
	class FormFormatter < Trenni::Formatters::Formatter
		include Trenni::Formatters::HTML::DefinitionListForm
		
		def select(options = {}, &block)
			element(Trenni::Formatters::HTML::RadioSelect, options, &block)
		end
	end
	
	describe Trenni::Formatters::HTML::RadioSelect do
		let(:formatter) {FormFormatter.new(:object => double(:bar => 10))}
		
		it "should list items" do
			_out = Trenni::Template.capture do
				formatter.select :field => :bar do |select|
					_out << select.item(:title => "A", :value => 0)
					_out << select.item(:title => "B", :value => 10)
				end
			end
			
			expect(_out).to be == %Q{<dt>Bar</dt>\n<dd>\n\t<table>\n\t\t<tbody>\n\t\t\t<tr>\n\t\t\t\t<td class="handle"><input type="radio" name="bar" value="0"/></td>\n\t\t\t\t<td class="item">A</td>\n\t\t\t</tr><tr>\n\t\t\t\t<td class="handle"><input type="radio" name="bar" value="10"/></td>\n\t\t\t\t<td class="item">B</td>\n\t\t\t</tr>\n\t\t</tbody>\n\t</table>\n</dd>}
		end
	end
end
