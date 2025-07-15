# frozen_string_literal: true

# Released under the MIT License.
# Copyright, 2016-2025, by Samuel Williams.

require "markly"

require "xrb/markup"
require "xrb/sanitize/fragment"

module XRB
	module Formatters
		module Markdown
			def markdown(text, filter = XRB::Sanitize::Fragment, **options)
				root = Markly.parse(text, **options)
				
				html = filter.parse(root.to_html).output
				
				return MarkupString.raw(html)
			end
		end
	end
end
