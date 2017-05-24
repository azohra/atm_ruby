module TMJ
  class BaseError < StandardError
    extend Forwardable

    def_instance_delegators :response, :code
    attr_reader :response
    
    def raise_400
      "\nStatus Code: 400\nError Message:\n#{response.parsed_response['errorMessages'].join("\n")}"
    end
    
    def raise_401
      "\nStatus Code: 401\nError Message: Client must be authenticated to access this resource."
    end

    def raise_404(error_message)
      "\nStatus Code: 404\nError Message: #{error_message}"
    end

    def raise_500
      "\nStatus Code: 500\nError Message: Internal server error."
    end
  end
end
