require 'base64'

module ATM
  # ATM::Client client for working with Adaptavist Test Management.
  class Client
    attr_accessor :auth_header

    def initialize(**args)
      options = ATM.config.to_hash.merge(args)
      options.each do |key, value|
        singleton_class.class_eval { attr_accessor key }
        send("#{key}=", value)
      end
      case options[:auth_type]
      when :basic then @auth_header = set_access_token
      else raise 'Currently only supports basic authentication'
      end
    end

    def gen_auth_token
      (Base64.encode64(username + ':' + password)[0..-2]).to_s
    end

    def set_access_token
      { 'Authorization' => "Basic #{gen_auth_token}",
        'Content-Type' => 'application/json' }
    end

    def TestPlan
      ATM::Services::TestPlan.new(auth_header: auth_header, base_url: base_url)
    end

    def TestCase
      ATM::Services::TestCase.new(auth_header: auth_header, base_url: base_url,
                                  environment: environment, project_id: project_id)
    end

    def TestRun
      ATM::Services::TestRun.new(auth_header: auth_header, base_url: base_url,
                                  environment: environment, test_run_id: test_run_id)    
    end
  end # Client
end # ATM