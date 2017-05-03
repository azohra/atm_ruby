require_relative '../error_handeling/test_plan_error'

module TMJ
  module Services
    # TMJ::Services::TestPlan
    class TestPlan < TMJ::Services::Base
      # Retrives data for specific test plan
      #
      # @param [String] plan_key
      #
      # @example Retrive data for a plan_key
      # plan_data = TMJ::CLinet.new.TestPlan.find('RR-P20')
      def find(plan_key)
        @response = self.class.get("/rest/kanoahtests/1.0/testplan/#{plan_key.upcase}", headers: header)
        raise TMJ::TestPlanError, response unless response.code == 200
        self
      end
    end
  end
end
