# Trenni::Formatters

Trenni is a templating system, and these formatters assist with the development
of typical view and form based web interface. A formatter is a high-level
adapter that turns model data into presentation text.

Formatters are designed to be customised, typically per-project, for specific
formatting needs.

[![Build Status](https://travis-ci.org/ioquatix/trenni-formatters.svg?branch=master)](https://travis-ci.org/ioquatix/trenni-formatters)
[![Code Climate](https://codeclimate.com/github/ioquatix/trenni-formatters.png)](https://codeclimate.com/github/ioquatix/trenni-formatters)
[![Coverage Status](https://coveralls.io/repos/ioquatix/trenni-formatters/badge.svg)](https://coveralls.io/r/ioquatix/trenni-formatters)

## Motivation

`Trenni::Formatters` was a library extracted from [Financier](https://github.com/ioquatix/financier) which is a CouchDB backed invoicing system, itself, derived from an old Rails app. I was a bit envious of `form_for` in terms of the ease of generating forms, but found that it wasn't very extendable. I also found myself generating code to format model data as rich HTML. `Trenni::Formatters` attempts to be an easily extendable formatting module which can generate rich text, links and HTML.

## Installation

Add this line to your application's Gemfile:

	gem 'trenni-formatters'

And then execute:

	$ bundle

Or install it yourself as:

	$ gem install trenni-formatters

## Usage

The most basic usage involves converting model data into presentation text by
a mapping corresponding to the objects type:

	formatter = Trenni::Formatters::Formatter.new
		
	formatter.for(String) do |value, options|
		"String: #{value}"
	end
		
	expect(formatter.format("foobar")).to be == "String: foobar"

For more examples please see `spec/`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Released under the MIT license.

Copyright, 2014, by [Samuel G. D. Williams](http://www.codeotaku.com/samuel-williams).

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.