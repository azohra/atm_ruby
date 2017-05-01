module TMJ
  class Client
    include HTTParty

    attr_reader :response, :header

    def initialize(options = {})
      options = TMJ.config.to_hash.merge(options)
      self.class.base_uri options[:base_url]
      case options[:auth_type]
      when :basic
         set_access_token(options[:username], options[:password])
      else
        raise 'Currently only supports basic authentication'
      end
    end

    def set_access_token(username,password)
      @header = { "Authorization" => "Basic #{Base64.encode64(username+':'+password)[0..-2]}", "Content-Type" => "application/json"}
    end

    def TestPlan(plan_id)
      TMJ::Services::TestPlan.new(plan_id)
    end
  end
end
