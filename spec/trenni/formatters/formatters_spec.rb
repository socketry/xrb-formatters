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

require 'trenni/formatters'

module Trenni::FormattersSpec
	class TestFormatter < Trenni::Formatters::Formatter
		def initialize(*arguments, **options)
			@count = 0
			
			super
		end
		
		attr :count
		
		map(String) do |value, options|
			@count += 1
			
			"String: #{value}"
		end
	end
	
	describe Trenni::Formatters do
		let(:test_formatter) {TestFormatter.new(foo: :bar)}
	
		it "should format string" do
			expect(test_formatter.format("foobar")).to be == "String: foobar"
			expect(test_formatter.count).to be == 1
		end
	
		it "should format numbers" do
			expect(test_formatter.format(10)).to be == "10"
			expect(test_formatter.count).to be == 0
		end
		
		it "has options" do
			expect(test_formatter[:foo]).to be == :bar
		end
	end
end
