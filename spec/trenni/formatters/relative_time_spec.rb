# frozen_string_literal: true

# Copyright, 2017, by Samuel G. D. Williams. <http://www.codeotaku.com>
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

require 'trenni/formatters/formatter'
require 'trenni/formatters/relative_time'

describe Trenni::Formatters::RelativeTime do
	subject {Class.new(Trenni::Formatters::Formatter).include(Trenni::Formatters::RelativeTime).new}
	
	let(:now) {Time.now}
	let(:time_this_year) {Time.mktime(now.year, 1, 1)}
	let(:time_last_year) {Time.mktime(now.year - 1, 1, 1)}
	
	it "should format without year" do
		expect(subject.format(time_this_year, current_time: now)).to be == "January 1, 12:00am"
	end
	
	it "should format with year" do
		expect(subject.format(time_last_year, current_time: now)).to be == "January 1, 12:00am, #{time_last_year.year}"
	end
end
