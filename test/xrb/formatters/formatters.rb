# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2012-2025, by Samuel Williams.

require "xrb/formatters"

class TestFormatter < XRB::Formatters::Formatter
	def initialize(*arguments, **options)
		@count = 0
		
		super
	end
	
	attr :count
	
	map(String) do |value, **options|
		@count += 1
		
		"String: #{value}"
	end
end

describe XRB::Formatters do
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
