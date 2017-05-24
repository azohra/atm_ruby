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
        self.class.get("/rest/kanoahtests/1.0/testplan/#{plan_key.upcase}", headers: header).tap do |response|
          raise TMJ::TestPlanError, response unless response.code == 200
        end
      end
    end
  end
end
