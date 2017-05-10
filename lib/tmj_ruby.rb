require 'httparty'
require 'base64'

require_relative 'configuration'
require_relative 'tmj_ruby/helpers/base_service'
require_relative 'tmj_ruby/helpers/test_case'

require_relative 'tmj_ruby/error_handeling/test_plan_error'
require_relative 'tmj_ruby/error_handeling/test_run_error'
require_relative 'tmj_ruby/error_handeling/test_case_error'

require_relative 'tmj_ruby/services/test_plan'
require_relative 'tmj_ruby/services/test_case'
require_relative 'tmj_ruby/services/test_run'

require_relative 'client'

require 'tmj_ruby/version'
