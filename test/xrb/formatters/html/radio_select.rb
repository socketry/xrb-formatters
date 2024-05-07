# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2016-2024, by Samuel Williams.

require 'xrb/formatters'
require 'xrb/formatters/html/radio_select'

class FormFormatter < XRB::Formatters::Formatter
	include XRB::Formatters::HTML::DefinitionListForm
	
	def select(**options, &block)
		element(XRB::Formatters::HTML::RadioSelect, **options, &block)
	end
end

Model = Struct.new(:bar)

describe XRB::Formatters::HTML::RadioSelect do
	let(:formatter) {FormFormatter.new(:object => Model.new(10))}
	
	it "should list items" do
		_out = XRB::Builder.new
		
		captured = XRB::Template.capture do
			formatter.select :field => :bar do |select|
				_out << select.item(:title => "A", :value => 0)
				_out << select.item(:title => "B", :value => 10)
			end
		end
		
		expect(captured).to be == <<~HTML.chomp
			<dt>Bar</dt>
			<dd>
				<table>
					<tbody>
						<tr>
							<td class="handle"><input type="radio" name="bar" value="0"/></td>
							<td class="item">A</td>
						</tr>
						<tr>
							<td class="handle"><input type="radio" name="bar" value="10" checked/></td>
							<td class="item">B</td>
						</tr>
					</tbody>
				</table>
			</dd>
		HTML
	end
	
	it "can capture item from block" do
		_out = XRB::Builder.new
		
		captured = XRB::Template.capture do
			formatter.select :field => :bar do |select|
				select.item(value: "A") do
					_out << "Hello World"
				end
			end
		end
		
		expect(captured).to be == <<~HTML.chomp
			<dt>Bar</dt>
			<dd>
				<table>
					<tbody>
						<tr>
							<td class="handle"><input type="radio" name="bar" value="A"/></td>
							<td class="item">Hello World</td>
						</tr>
					</tbody>
				</table>
			</dd>
		HTML
	end
end
