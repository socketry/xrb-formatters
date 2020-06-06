# frozen_string_literal: true

# Copyright, 2012, by Samuel G. D. Williams. <http://www.codeotaku.com>
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

require 'trenni/strings'
require 'mapping/model'

module Trenni
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
				
				omission ||= '...'
				
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
