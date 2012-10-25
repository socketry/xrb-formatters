
require 'trenni/builder'

module Trenni
	module Formatters
		module HTML
			# Table based select boxes using per-row checkboxes.
			class TableSelect
				def self.call(formatter, options, builder, &block)
					instance = self.new(formatter, options, builder)
					
					instance.call(options, &block)
				end
				
				def initialize(formatter, options, builder)
					@formatter = formatter
					@object = formatter.object
					@field = options[:field]
					
					@builder = builder
				end

				def name_for(options)
					@formatter.name_for(options)
				end

				def value_for(options)
					@formatter.value_for(options)
				end

				def title_for(options)
					@formatter.title_for(options)
				end

				def radio_attributes_for(options)
					return {
						:type => :radio,
						:name => @field,
						:value => value_for(options),
						:selected => options[:selected],
					}
				end

				def item(options = {}, &block)
					fragment = Builder.fragment do |builder|
						builder.tag :tr do
							builder.inline(:td, :class => :handle) do
								builder.tag :input, radio_attributes_for(options)
							end
								
							builder.inline(:td, :class => :item) do
								if block_given?
									builder.append Trenni::Template.capture(self, &block)
								else
									builder.text title_for(options)
								end
							end
						end
					end
					
					if block_given?
						buffer = Trenni::buffer(block.binding)
						buffer << fragment
						
						return nil
					else
						return fragment
					end
				end

				def call(options = {}, &block)
					Builder.fragment(@builder) do |builder|
						builder.tag :table do
							builder.tag :tbody do
								builder.append Trenni::Template.capture(self, &block)
							end
						end
					end
				end
			end

		end
	end
end
