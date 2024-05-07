# XRB::Formatters

XRB is a templating system, and these formatters assist with the development
of typical view and form based web interface. A formatter is a high-level
adapter that turns model data into presentation text.

Formatters are designed to be customised, typically per-project, for specific
formatting needs.

[![Development Status](https://github.com/socketry/xrb-formatters/workflows/Test/badge.svg)](https://github.com/socketry/xrb-formatters/actions?workflow=Test)

## Motivation

`XRB::Formatters` was a library extracted from [Financier](https://github.com/ioquatix/financier), an small business management app, itself, derived from an old Rails app. I was a bit envious of `form_for` in terms of the ease of generating forms, but found that it wasn't very extendable. I also found myself generating code to format model data as rich HTML. `XRB::Formatters` attempts to be an easily extendable formatting module which can generate rich text, links and HTML.

## Installation

Add this line to your application's Gemfile:

    gem 'xrb-formatters'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install xrb-formatters

## Usage

The most basic usage involves converting model data into presentation text by
a mapping corresponding to the objects type:

``` ruby
formatter = XRB::Formatters::Formatter.new
	
formatter.for(String) do |value, **options|
	"String: #{value}"
end
	
expect(formatter.format("foobar")).to be == "String: foobar"
```

For more examples please see `spec/`.

## Contributing

We welcome contributions to this project.

1.  Fork it.
2.  Create your feature branch (`git checkout -b my-new-feature`).
3.  Commit your changes (`git commit -am 'Add some feature'`).
4.  Push to the branch (`git push origin my-new-feature`).
5.  Create new Pull Request.

### Developer Certificate of Origin

This project uses the [Developer Certificate of Origin](https://developercertificate.org/). All contributors to this project must agree to this document to have their contributions accepted.

### Contributor Covenant

This project is governed by the [Contributor Covenant](https://www.contributor-covenant.org/). All contributors and participants agree to abide by its terms.
