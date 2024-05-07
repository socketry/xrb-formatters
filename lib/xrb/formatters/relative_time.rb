# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2016-2024, by Samuel Williams.

require 'xrb/strings'
require 'mapping/model'

module XRB
	module Formatters
		module RelativeTime
			def self.included(base)
				base.map(Time) do |object, **options|
					current_time = options.fetch(:current_time) {Time.now}
					
					# Ensure we display the time in localtime, and show the year if it is different:
					if object.localtime.year != current_time.year
						object.localtime.strftime("%B %-d, %-l:%M%P, %Y")
					else
						object.localtime.strftime("%B %-d, %-l:%M%P")
					end
				end
			end
		end
	end
end
