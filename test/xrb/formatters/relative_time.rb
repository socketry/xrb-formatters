# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2017-2025, by Samuel Williams.

require "xrb/formatters/formatter"
require "xrb/formatters/relative_time"

describe XRB::Formatters::RelativeTime do
	let(:formatter) {Class.new(XRB::Formatters::Formatter).include(XRB::Formatters::RelativeTime).new}
	
	let(:now) {Time.now}
	let(:time_this_year) {Time.mktime(now.year, 1, 1)}
	let(:time_last_year) {Time.mktime(now.year - 1, 1, 1)}
	
	it "should format without year" do
		expect(formatter.format(time_this_year, current_time: now)).to be == "January 1, 12:00am"
	end
	
	it "should format with year" do
		expect(formatter.format(time_last_year, current_time: now)).to be == "January 1, 12:00am, #{time_last_year.year}"
	end
end
