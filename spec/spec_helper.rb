require 'coveralls'
Coveralls.wear!

require 'bundler/setup'
require 'atm_ruby'
require 'pry'
require 'webmock'
require 'vcr'

ATM.configure do |c|
  c.base_url    = 'http://localhost'
  c.auth_type   = :basic
  c.project_id  = 'CC'
  c.test_run_id = ''
  c.environment = ''.upcase
  c.username    = 'Test'
  c.password    = 'test'
end

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
