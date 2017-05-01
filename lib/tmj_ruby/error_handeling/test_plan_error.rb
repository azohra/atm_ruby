require_relative 'base_error'
module TMJ
  class TestPlanError < BaseError
    attr_reader :message

    def initialize(response)
      @response = response
      @message = case response.code
                 when 401 then raise_401
                 when 404 then raise_404
                 else 'Something'
                 end
    end

    def raise_404
      'No Test Plan has been found with the given key'
    end
  end
end

# 401 - Authentication error. See the JIRA REST API docs for details.
# {
#   status: {
#     statusCode: 401,
#     message: "Client must be authenticated to access this resource."
#   }
# }

# 404 - No Test Plan has been found with the given key.
