# Ygrene Istio Tracing Gem

Rails instrumentation gem for Istio service mesh (https://istio.io/).

This gem lets your Rails services propagate b3 http headers for distributed tracing with Istio.
It propigates headers to Net::Http and Typhoeus(uses libcurl)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'ygrene-istio-tracing'
```
## Usage

Installed into the rails-setup gem for ygrene usage.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).
