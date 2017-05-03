require 'coveralls'
Coveralls.wear!

require 'webmock/rspec'
require 'bundler/setup'
require 'tmj_ruby'
require 'pry'

WebMock.disable_net_connect!(allow_localhost: true)

TMJ.configure do |c|
  c.base_url    = 'http://localhost'
  c.auth_type   = :basic
  c.project_id  = 'CC'
  c.test_run_id = 'ss'
  c.environment = ''.upcase
  c.username    = 'Test'
  c.password    = 'test'
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

def get_mock_response(file)
  File.read(File.join(File.dirname(__FILE__), 'mock_responses/', file))
end
