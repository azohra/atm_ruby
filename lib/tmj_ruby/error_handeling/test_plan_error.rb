require_relative '../helpers/base_error'
module TMJ
  class TestPlanError < TMJ::BaseError
    attr_reader :message

    def initialize(response)
      @response = response
      @message = case response.code
                 when 401 then raise_401
                 when 404 then raise_404
                 end
    end

    def raise_404
      'No Test Plan has been found with the given key'
    end
  end
end
