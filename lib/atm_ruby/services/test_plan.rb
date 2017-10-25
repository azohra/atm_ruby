module ATM
  module Services
    # ATM::Services::TestPlan
    class TestPlan < ATM::Services::Base
      # Retrives data for specific test plan
      #
      # @param [String] plan_key
      #
      # @example Retrive data for a plan_key
      # plan_data = ATM::CLinet.new.TestPlan.find('RR-P20')
      def find(plan_key)
        self.class.get("/rest/kanoahtests/1.0/testplan/#{plan_key.upcase}", headers: auth_header).tap do |response|
          @response = response
          raise ATM::TestPlanError, response unless response.code == 200
        end
      end
    end
  end
end
