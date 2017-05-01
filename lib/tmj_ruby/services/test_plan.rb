module TMJ
  module Services
    class TestPlan
      attr_reader :test_plan_id
      def initialize(plan_id)
        @test_plan_id = plan_id
      end

      def find(plan_id)
      end
    end
  end
end
