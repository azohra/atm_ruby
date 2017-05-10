module TMJ
  class Client
    attr_reader :services_options

    def initialize(options = {})
      options = TMJ.config.to_hash.merge(options)
      case options[:auth_type]
      when :basic
        header = set_access_token(options[:username], options[:password])
      else
        raise 'Currently only supports basic authentication'
      end
      @services_options = configure_services_options(header, options)
    end

    def set_access_token(username, password)
      { 'Authorization' => "Basic #{Base64.encode64(username + ':' + password)[0..-2]}", 'Content-Type' => 'application/json' }
    end

    def configure_services_options(header, options = {})
      {
        header: header,
        base_url: options[:base_url],
        project_id: options[:project_id],
        environment: options[:environment],
        test_run_id: options[:test_run_id]
      }
    end

    def TestPlan
      TMJ::Services::TestPlan.new(services_options)
    end

    def TestCase
      TMJ::Services::TestCase.new(services_options)
    end

    def TestRun
      TMJ::Services::TestRun.new(services_options)
    end
  end
end
