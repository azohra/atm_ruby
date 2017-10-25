require 'httparty'

require 'atm_ruby/version'
require 'atm_ruby/configuration'
require 'atm_ruby/helpers/base_service'

require 'atm_ruby/error_handeling/test_plan_error'
require 'atm_ruby/error_handeling/test_case_error'
require 'atm_ruby/error_handeling/test_run_error'

require 'atm_ruby/services/test_plan'
require 'atm_ruby/services/test_case'
require 'atm_ruby/services/test_run'

require 'atm_ruby/client'

ATM.configure { ; }
