# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2016-2025, by Samuel Williams.

require "xrb/strings"
require "mapping/model"

module XRB
	module Formatters
		module TruncatedText
			def truncated_text(content, length: 30, **options)
				if content
					content = TruncatedText.truncate_text(content, length, **options)
					
					return self.format(content)
				end
			end
			
			def self.truncate_text(text, truncate_at, omission: nil, separator: nil, **options)
				return text.dup unless text.length > truncate_at
				
				omission ||= "..."
				
				length_with_room_for_omission = truncate_at - omission.length
				
				stop = nil
				
				if separator
					stop = text.rindex(separator, length_with_room_for_omission)
				end
				
				stop ||= length_with_room_for_omission
				
				"#{text[0...stop]}#{omission}"
			end
		end
	end
end
