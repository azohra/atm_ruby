module TMJ
    class << self
      attr_accessor :config
    end

    def self.configure
      self.config ||= Configuration.new
      yield(config)
    end

    class Configuration
      attr_accessor :base_url, :test_run_id, :environment, :username, :password, :project_id, :auth_type

      def initialize
        @base_url    = nil
        @test_run_id = nil
        @project_id  = nil
        @environment = nil
        @username    = nil
        @password    = nil
        @auth_type   = nil
      end

      def to_hash
        hash = {}
        self.instance_variables.each {|var| hash[var.to_s.delete("@").to_sym] = self.instance_variable_get(var) }
        hash
      end
    end
  end
