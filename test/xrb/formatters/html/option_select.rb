# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2014-2024, by Samuel Williams.

require 'xrb/formatters'
require 'xrb/formatters/html/definition_list_form'
require 'xrb/formatters/html/option_select'

Model = Struct.new(:bar)

class FormFormatter < XRB::Formatters::Formatter
	include XRB::Formatters::HTML::DefinitionListForm
	
	def select(**options, &block)
		element(XRB::Formatters::HTML::OptionSelect, **options, &block)
	end
end

describe XRB::Formatters::HTML::OptionSelect do
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
				<select name="bar">
					<option value="0">A</option>
					<option value="10" selected>B</option>
				</select>
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
			<select name="bar">
				<option value="A">Hello World</option>
			</select>
		</dd>
		HTML
	end
	
	it "should list items with data attributes" do
		_out = XRB::Builder.new
		
		captured = XRB::Template.capture do
			formatter.select :field => :bar do |select|
				_out << select.item(:title => "A", :value => 0, :data => {foo: 'bar'})
			end
		end
		
		expect(captured).to be == <<~HTML.chomp
			<dt>Bar</dt>
			<dd>
				<select name="bar">
					<option value="0" data-foo="bar">A</option>
				</select>
			</dd>
		HTML
	end
	
	it "should list items for multiple selection" do
		_out = XRB::Builder.new
		
		captured = XRB::Template.capture do
			formatter.select :field => :bar, multiple: true do |select|
				_out << select.item(:title => "A", :value => 0)
				_out << select.item(:title => "B", :value => 10)
			end
		end
		
		expect(captured).to be == <<~HTML.chomp
			<dt>Bar</dt>
			<dd>
				<select name="bar[]" multiple>
					<option value="0">A</option>
					<option value="10" selected>B</option>
				</select>
			</dd>
		HTML
	end
	
	it "should add optional item" do
		_out = XRB::Builder.new
		
		captured = XRB::Template.capture do
			formatter.select :field => :bar, optional: true do |select|
				_out << select.item(:title => "A", :value => 0)
				_out << select.item(:title => "B", :value => 10)
			end
		end
		
		
		expect(captured).to be == <<~HTML.chomp
			<dt>Bar</dt>
			<dd>
				<select name="bar">
					<option></option>
					<option value="0">A</option>
					<option value="10" selected>B</option>
				</select>
			</dd>
		HTML
	end
	
	it "should add optional item in group" do
		_out = XRB::Builder.new
		
		captured = XRB::Template.capture do
			formatter.select :field => :bar do |select|
				select.group(title: 'group', optional: true) do
					_out << select.item(:title => "A", :value => 0)
				end
				_out << select.item(:title => "B", :value => 10)
			end
		end
		
		expect(captured).to be == <<~HTML.chomp
			<dt>Bar</dt>
			<dd>
				<select name="bar">
					<optgroup label="group">
						<option></option>
						<option value="0">A</option>
					</optgroup>
					<option value="10" selected>B</option>
				</select>
			</dd>
		HTML
	end
	
	it "should add a group" do
		_out = XRB::Builder.new
		
		captured = XRB::Template.capture do
			formatter.select :field => :bar do |select|
				select.group(title: 'group') do
					_out << select.item(:title => "A", :value => 0)
				end
				_out << select.item(:title => "B", :value => 10)
			end
		end
		
		expect(captured).to be == <<~HTML.chomp
			<dt>Bar</dt>
			<dd>
				<select name="bar">
					<optgroup label="group">
						<option value="0">A</option>
					</optgroup>
					<option value="10" selected>B</option>
				</select>
			</dd>
		HTML
	end
end
