# Adaptavist Test Management API Wrapper
[![Gem Version](https://badge.fury.io/rb/atm_ruby.svg)](https://badge.fury.io/rb/atm_ruby)
[![Build Status](https://travis-ci.org/automation-wizards/atm_ruby.svg?branch=master)](https://travis-ci.org/automation-wizards/atm_ruby)
[![Coverage Status](https://coveralls.io/repos/github/automation-wizards/atm_ruby/badge.svg?branch=master)](https://coveralls.io/github/automation-wizards/atm_ruby?branch=master)
[![Inline docs](http://inch-ci.org/github/automation-wizards/atm_ruby.svg?branch=master)](http://inch-ci.org/github/automation-wizards/atm_ruby)
[![Dependency Status](https://gemnasium.com/badges/github.com/automation-wizards/atm_ruby.svg)](https://gemnasium.com/github.com/automation-wizards/atm_ruby)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'atm_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install atm_ruby

## Usage(Look for API refferences [here](https://www.kanoah.com/docs/public-api/1.0/))

#### Configuration

Setup configuration in your setup file if you need to configure it once
```ruby
ATM.configure do |c|
  c.base_url    = 'http://localhost'
  c.auth_type   = :basic
  c.project_id  = 'PD'
  c.test_run_id = 'TR-I123'
  c.environment = 'Mobile'
  c.username    = 'Test'
  c.password    = 'test'
end
```

Or do it everytime you create a client
```ruby
client = ATM::Client.new(base_url: 'http://localhost', auth_type: :basic, 
                         project_id: 'PD', test_run_id: 'TR-I123', 
                         environment: 'Mobile', username: 'Test', password: 'test')
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/atm_ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
