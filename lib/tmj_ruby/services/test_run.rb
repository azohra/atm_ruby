module TMJ
  module Services
    # TMJ::Services::TestRun provides methods for working with test runs
    #
    # @see https://www.kanoah.com/docs/public-api/1.0/ more info regarding test cases can be found here
    #
    class TestRun < TMJ::Services::Base
      attr_reader :test_run_id, :environment

      def initialize(**args)
        @test_run_id = args.delete(:test_run_id)
        @environment = args.delete(:environment)
        super(args)
      end
    
      # Creates new test run
      #
      # @param [Hash] test_run_data
      #
      # @example Create new test case
      #   TMJ::Client.new.TestRun.create({"name": "Full regression","projectKey": "JQA"})
      #
      def create(test_run_data)
        self.class.post("/rest/kanoahtests/1.0/testrun", body: test_run_data.to_json, headers: auth_header).tap do |r|
          @response = r
          raise TMJ::TestRunError, response unless code == 201
        end
      end
      
      # Retrive specific test run
      #
      # @param [String] test_run_id
      #
      # @example Create new test case
      #   TMJ::Client.new.TestRun.find('DD-R123')
      #
      def find(test_run_id)
        self.class.get("/rest/kanoahtests/1.0/testrun/#{test_run_id}", headers: auth_header).tap do |r|
          @response = r
          raise TMJ::TestRunError, response unless code == 200
        end
      end
      
      # Delete specific test run
      #
      # @param [String] test_run_id
      #
      # @example Create new test case
      #   TMJ::Client.new.TestRun.delete('DD-R123')
      #
      def delete(test_run_id)
        self.class.delete("/rest/kanoahtests/1.0/testrun/#{test_run_id}", headers: auth_header).tap do |r|
          @response = r
          raise TMJ::TestRunError, response unless code == 204
        end
      end
      
      # Searches for a testrun based on the provided quiry
      #
      # @param [String] test_run_id
      #
      # @example Create new test case
      #   TMJ::Client.new.TestRun.search('projectKey = "JQA"')
      #
      def search(query_string)
        self.class.get("/rest/kanoahtests/1.0/testrun/search?query=#{query_string}", headers: auth_header).tap do |r|
          @response = r
          raise TMJ::TestRunError, response unless code == 200
        end
      end
      
      # Create new result for a test run
      #
      # @param [String] test_run_key
      # @param [String] test_case_id
      # @param [Hash]   test_data      
      #
      # @example
      #   test_data = {
      #   "status": "Fail",
      #   "scriptResults": [
      #     {
      #       "index": 0,
      #       "status": "Fail",
      #       "comment": "This steps has failed."
      #     }
      #   ]
      # }
      #   TMJ::Client.new.TestRun.create_new_test_run_result('DD-R123','DD-T123', test_data)
      #
      def create_new_test_run_result(test_run_key = @test_run_id, test_case_id, test_data)
        self.class.post("/rest/kanoahtests/1.0/testrun/#{test_run_key}/testcase/#{test_case_id}/testresult", body: test_data.to_json, headers: auth_header).tap do |r|
          @response = r
          raise TMJ::TestRunError, response unless code == 201
        end
      end
      
      # Update latest result for a test run
      #
      # @param [String] test_run_key
      # @param [String] test_case_id
      # @param [Hash]   test_data      
      #
      # @example
      #   test_data = {
      #   "status": "Fail",
      #   "scriptResults": [
      #     {
      #       "index": 0,
      #       "status": "Fail",
      #       "comment": "This steps has failed."
      #     }
      #   ]
      # }
      #   TMJ::Client.new.TestRun.update_last_test_run_result('DD-R123','DD-T123', test_data)
      #
      def update_last_test_run_result(test_run_key = @test_run_id, test_case_id, test_data)
        self.class.post("/rest/kanoahtests/1.0/testrun/#{test_run_key}/testcase/#{test_case_id}/testresult", body: test_data.to_json, headers: auth_header).tap do |r|
          @response = r
        end
          # raise TMJ::TestRunError, response unless response.code == 200
      end

      def process_result(test_data)
        {
            'status'        => test_data[:status],
            'environment'   => test_data.fetch(:environment, @environment),
            'comment'       => test_data.fetch(:comment, nil),
            'userKey'       => test_data.fetch(:username, nil),
            'executionTime' => test_data.fetch(:execution_time, nil),
            'executionDate' => test_data.fetch(:execution_date, nil),
            'scriptResults' => test_data[:script_results]
        }.delete_if { |k, v| v.nil? }
      end
    end
  end
end
