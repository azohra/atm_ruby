require_relative '../error_handeling/test_plan_error'

module TMJ
  module Services
    class TestPlan
      include HTTParty

      default_options.update(verify: false)
      format :json

      attr_reader :test_plan_id, :response, :header

      def initialize(header, base_url)#plan_id)
        self.class.base_uri base_url
        @header = header
        # @test_plan_id = plan_id
      end

      def find(plan_key)
        @response = self.class.get("/rest/kanoahtests/1.0/testplan/#{plan_key}", headers: header)
        raise TMJ::TestPlanError, response unless response.code == 200
        self
      end
    end
  end
end
