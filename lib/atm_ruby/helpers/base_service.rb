require 'forwardable'

module ATM
  module Services
    # ATM::Services::Base Base class for all of the services
    #
    # @attr_reader [] response - holds data after post/put/delete/get submited
    # @attr_reader [Hash] header - access token for authentication
    # @attr_reader [String] project_id - user set project id
    #
    class Base
      include HTTParty
      extend Forwardable

      default_options.update(verify: false)
      format :json

      attr_reader :auth_header, :response
      def_delegators :@response, :code, :body, :header

      def initialize(**args)
        self.class.base_uri args[:base_url]
        @auth_header = args[:auth_header]
      end
    end
  end
end