#!/usr/bin/env ruby

# Copyright (c) 2012 Samuel G. D. Williams. <http://www.codeotaku.com>
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

require 'pathname'
require 'test/unit'
require 'stringio'

require 'trenni/formatters'
require 'trenni/formatters/html/definition_list_form'
require 'trenni/formatters/html/option_select'
require 'trenni/formatters/html/table_select'

class TestFormsFormatter < Test::Unit::TestCase
	class BasicFormatter < Trenni::Formatters::Formatter
		include Trenni::Formatters::HTML::DefinitionListForm
	end
	
	class Foo
		attr :bar, true
	end
	
	def test_basic_formatter
		object = Foo.new
		object.bar = 10

		formatter = BasicFormatter.new(:object => object)

		assert_equal %Q{<dt>Bar</dt>\n<dd><input name="bar" value="10"/></dd>}, formatter.input(:field => :bar)
	end
end
