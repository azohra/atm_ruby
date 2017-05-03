module TMJ
  module Services
    # TMJ::Services::Base Base class for all of the services
    #
    # @attr_reader [] response - holds data after post/put/delete/get submited
    # @attr_reader [Hash] header - access token for authentication
    # @attr_reader [String] project_id - user set project id
    #
    class Base
      include HTTParty

      default_options.update(verify: false)
      format :json

      attr_reader :response, :header, :project_id

      def initialize(options = {}) # TODO: add exception for project_id
        self.class.base_uri options[:base_url]
        @header     = options[:header]
        @project_id = options[:project_id]
        @environment = options.fetch(:environment) { nil }
      end
    end
  end
end
