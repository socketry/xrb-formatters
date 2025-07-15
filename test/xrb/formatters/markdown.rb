# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2024-2025, by Samuel Williams.

require "xrb/formatters/formatter"
require "xrb/formatters/markdown"

describe XRB::Formatters::Markdown do
	let(:formatter) {Class.new(XRB::Formatters::Formatter).include(XRB::Formatters::Markdown).new}
	
	let(:sample_text) {"# Heading\n\nParagraph\n"}
	
	it "should format markdown" do
		result = formatter.markdown(sample_text)
		
		expect(result).to be == <<~HTML
			<h1>Heading</h1>
			<p>Paragraph</p>
		HTML
	end
end
