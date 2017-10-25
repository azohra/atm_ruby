require_relative '../helpers/base_error'
module ATM
  class TestCaseError < ATM::BaseError
    attr_reader :message

    def initialize(response)
      @response = response
      @message = case response.code
                 when 400 then raise_400
                 when 401 then raise_401
                 when 404 then raise_404('No Test Case has been found with the given key.')
                 when 500 then raise_500
                 end
    end
  end
end
