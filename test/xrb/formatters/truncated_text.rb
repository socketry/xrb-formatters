# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2024-2025, by Samuel Williams.

require "xrb/formatters/formatter"
require "xrb/formatters/truncated_text"

describe XRB::Formatters::TruncatedText do
	let(:formatter) {Class.new(XRB::Formatters::Formatter).include(XRB::Formatters::TruncatedText).new}
	
	let(:sample_text) {"The quick brown fox jumped over the lazy dog!"}
	
	it "should truncate text" do
		expect(formatter.truncated_text(sample_text)).to be == "The quick brown fox jumped ..."
	end
end
