# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2012-2025, by Samuel Williams.

require "xrb/formatters"
require "xrb/formatters/html/definition_list_form"

class FormFormatter < XRB::Formatters::Formatter
	include XRB::Formatters::HTML::DefinitionListForm
end

describe XRB::Formatters do
	let(:model) {Struct.new(:bar)}
	let(:formatter) {FormFormatter.for(model.new(10))}
	
	it "should generate form" do
		result = formatter.input(:field => :bar)
		expect(result).to be == <<~HTML.chomp
			<dt>Bar</dt>
			<dd><input name="bar" value="10"/></dd>
		HTML
	end
	
	it "should have default value" do
		expect(formatter.value_for(:value => 10)).to be == "10"
		expect(formatter.value_for(:value => nil, :default => 10)).to be == "10"
	end
	
	it "should have a different title" do
		result = formatter.input(:field => :bar, :title => "Title")
		expect(result).to be == <<~HTML.chomp
			<dt>Title</dt>
			<dd><input name="bar" value="10"/></dd>
		HTML
	end
	
	with "key" do
		let(:formatter) {FormFormatter.for(model.new(10), nested_name: "attributes")}
		
		it "should generate form with nested name" do
			result = formatter.input(:field => :bar)
			expect(result).to be == <<~HTML.chomp
				<dt>Bar</dt>
				<dd><input name="attributes[bar]" value="10"/></dd>
			HTML
		end
	end
	
	with "nested object" do
		let(:model) {Struct.new(:animal)}
		let(:animal) {Struct.new(:name)}
		
		let(:formatter) {FormFormatter.for(model.new(animal.new("cat")))}
		
		it "can generate nested attributes" do
			result = formatter.nested(:animal) do |formatter|
				formatter.input(field: :name)
			end
			
			expect(result).to be == <<~HTML.chomp
				<dt>Name</dt>
				<dd><input name="animal[name]" value="cat"/></dd>
			HTML
		end
	end
end

describe "<input>" do
	let(:model) {Struct.new(:bar, :bob, :dole)}
	let(:formatter) {FormFormatter.new(:object => model.new(10, true, false))}
	
	it "should support support min, max and step" do
		attributes = formatter.input_attributes_for(:min => 10, :max => 20, :step => 2)
		
		expect(attributes[:min]).to be == 10
		expect(attributes[:max]).to be == 20
		expect(attributes[:step]).to be == 2
		
		result = formatter.input(:field => :bar, :min => 10)
		expect(result).to be == <<~HTML.chomp
			<dt>Bar</dt>
			<dd><input name="bar" value="10" min="10"/></dd>
		HTML
	end
	
	it "should not specify required, readonly or disabled" do
		attributes = formatter.input_attributes_for(:field => :bar)
		expect(attributes[:required]).to be_nil
		expect(attributes[:readonly]).to be_nil
		expect(attributes[:disabled]).to be_nil
	end
	
	it "should specify required, readonly or disabled" do
		attributes = formatter.input_attributes_for(:field => :bar, :required => true, :readonly => true, :disabled => true)
		expect(attributes[:required]).to be_truthy
		expect(attributes[:readonly]).to be_truthy
		expect(attributes[:disabled]).to be_truthy
	end
	
	it "should generate checked checkbox" do
		attributes = formatter.checkbox_attributes_for(:value => true)
		expect(attributes[:checked]).to be_truthy
		
		result = formatter.checkbox(:field => :bob)
		expect(result).to be == <<~HTML.chomp
			<dd>
				<input type="hidden" name="bob" value="false"/>
				<label><input type="checkbox" name="bob" value="true" checked/> Bob</label>
			</dd>
		HTML
	end
	
	it "should generate unchecked checkbox" do
		attributes = formatter.checkbox_attributes_for(:value => false)
		expect(attributes[:checked]).to be_nil
		
		result = formatter.checkbox(:field => :dole)
		expect(result).to be == <<~HTML.chomp
			<dd>
				<input type="hidden" name="dole" value="false"/>
				<label><input type="checkbox" name="dole" value="true"/> Dole</label>
			</dd>
		HTML
	end
end

describe '<input type="hidden">' do
	let(:model) {Struct.new(:age)}
	let(:formatter) {FormFormatter.new(:object => model.new(20))}
	
	it "should generate hidden field" do
		result = formatter.hidden(:field => :age)
		expect(result).to be == <<~HTML.chomp
			<input type="hidden" name="age" value="20"/>
		HTML
	end
	
	it "should escape characters correctly" do
		expect(formatter.object).to receive(:new_record?).and_return(false)
		
		result = formatter.submit
		expect(result).to be == <<~HTML.chomp
			<input type="submit" value="Update"/>
		HTML
	end
	
	it "can have custom title" do
		result = formatter.submit(title: "Alice")
		expect(result).to be == <<~HTML.chomp
			<input type="submit" value="Alice"/>
		HTML
	end
end

describe '<input type="submit">' do
	let(:model) {Struct.new(:new_record?)}
	let(:new_record_formatter) {FormFormatter.new(:object => model.new(true))}
	let(:formatter) {FormFormatter.new(:object => model.new(false))}
	
	it "should have correct title for new_record?" do
		result = new_record_formatter.submit
		expect(result).to be == <<~HTML.chomp
			<input type="submit" value="Create"/>
		HTML
	end
	
	it "should escape characters correctly" do
		result = formatter.submit
		expect(result).to be == <<~HTML.chomp
			<input type="submit" value="Update"/>
		HTML
	end
	
	it "can have custom title" do
		result = formatter.submit(title: "Alice")
		expect(result).to be == <<~HTML.chomp
			<input type="submit" value="Alice"/>
		HTML
	end
end

describe "<textarea>" do
	let(:model) {Struct.new(:details)}
	let(:formatter) {FormFormatter.new(:object => model.new("foo<bar>"))}
	
	it "should escape characters correctly" do
		result = formatter.textarea(:field => :details).to_s
		expect(result).to be == <<~HTML.chomp
			<dt>
				Details
			</dt>
			<dd><textarea name="details">foo&lt;bar&gt;</textarea></dd>
		HTML
	end
end

describe "<output>" do
	let(:model) {Struct.new(:bar, :bob, :dole)}
	let(:formatter) {FormFormatter.new(:object => model.new(10, true, false))}
	
	it "should show output value" do
		result = formatter.output(:field => :bar)
		expect(result).to be == <<~HTML.chomp
			<dt>Bar</dt>
			<dd><output name="bar">10</output></dd>
		HTML
	end
	
	it "should show output value" do
		result = formatter.output(:name => :total)
		expect(result).to be == <<~HTML.chomp
			<dt></dt>
			<dd><output name="total"></output></dd>
		HTML
	end
end

describe "<button>" do
	let(:formatter) {FormFormatter.new}
	
	it "should generate reset button" do
		result = formatter.button(:type => :reset)
		expect(result).to be == <<~HTML.chomp
			<button type="reset">Reset</button>
		HTML
	end
end
