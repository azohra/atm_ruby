require 'httparty'

require 'tmj_ruby/version'
require 'tmj_ruby/configuration'
require 'tmj_ruby/helpers/base_service'

require 'tmj_ruby/error_handeling/test_plan_error'
require 'tmj_ruby/error_handeling/test_case_error'
require 'tmj_ruby/error_handeling/test_run_error'

require 'tmj_ruby/services/test_plan'
require 'tmj_ruby/services/test_case'
require 'tmj_ruby/services/test_run'

require 'tmj_ruby/client'

TMJ.configure { ; }
