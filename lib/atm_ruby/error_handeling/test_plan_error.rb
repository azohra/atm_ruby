require 'atm_ruby/helpers/base_error'

module ATM
  class TestPlanError < ATM::BaseError
    attr_reader :message

    def initialize(response)
      @response = response
      @message = case response.code
                   when 401 then raise_401
                   when 404 then raise_404('No Test Plan has been found with the given key')
                   when 500 then raise_500
                 end
    end
  end
end
