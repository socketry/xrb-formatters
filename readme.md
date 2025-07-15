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

Please see the [project documentation](https://github.com/ioquatix/xrb-formatters) for more details.

## Releases

Please see the [project releases](https://github.com/ioquatix/xrb-formattersreleases/index) for all releases.

### v0.1.1

## Contributing

We welcome contributions to this project.

1.  Fork it.
2.  Create your feature branch (`git checkout -b my-new-feature`).
3.  Commit your changes (`git commit -am 'Add some feature'`).
4.  Push to the branch (`git push origin my-new-feature`).
5.  Create new Pull Request.

### Developer Certificate of Origin

In order to protect users of this project, we require all contributors to comply with the [Developer Certificate of Origin](https://developercertificate.org/). This ensures that all contributions are properly licensed and attributed.

### Community Guidelines

This project is best served by a collaborative and respectful environment. Treat each other professionally, respect differing viewpoints, and engage constructively. Harassment, discrimination, or harmful behavior is not tolerated. Communicate clearly, listen actively, and support one another. If any issues arise, please inform the project maintainers.
