module TMJ
  module Services
    # TMJ::Services::TestCase provides methods for working with test cases
    #
    # @see https://www.kanoah.com/docs/public-api/1.0/ more info regarding test cases can be found here
    #
    class TestCase < TMJ::Services::Base
      include TMJ::Helper::TestCase

      # Creates new test case
      #
      # @param [Hash] body
      #
      # @example Create new test case
      #   TMJ::Client.new.TestCase.create({"projectKey": "JQA", "name": "Ensure the axial-flow pump is enabled"})
      #
      def create(body)
        self.class.post('/rest/kanoahtests/1.0/testcase', body: body.to_json, headers: @header).tap do |response|
          raise TMJ::TestCaseError, response unless response.code == 201
        end
      end

      # Updates test case
      #
      # @param [String] test_case_key
      #
      # @example Update existing test case
      #
      def update(test_case_id, body)
        self.class.put("/rest/kanoahtests/1.0/testcase/#{test_case_id}", body: body.to_json, headers: @header).tap do |response|
          raise TMJ::TestCaseError, response unless response.code == 200
        end
      end

      # Deletes test case
      #
      # @param [String] test_case_key
      #
      # @example Delete existing test case
      #
      def delete(test_case_id)
        self.class.delete("/rest/kanoahtests/1.0/testcase/#{test_case_id}", headers: @header).tap do |response|
          raise TMJ::TestCaseError, response unless response.code == 204
        end
      end

      # Finds specific test case
      #
      # @param [String] test_case_key
      #
      # @example Find existing test case
      #
      def find(test_case_id)
        self.class.get("/rest/kanoahtests/1.0/testcase/#{test_case_id}", headers: @header).tap do |response|
          raise TMJ::TestCaseError, response unless response.code == 200
        end
      end

      # Searches for test cases based on the provided quiry
      #
      # @param [String] query_string
      #
      # @example Search for an existed test case
      #
      def search(query_string)
        self.class.get("/rest/kanoahtests/1.0/testcase/search?query=#{query_string}", headers: @header).tap do |response|
          raise TMJ::TestCaseError, response unless response.code == 200
        end
      end

      # Adds  attachment to a test case
      #
      # @param [String] tese_case_id
      #
      # @example Add attachment to an existed test case
      #
      def add_attachment(_test_case_id) # TODO: need to fix this.
        warn 'Not implemented at the moment'
        # self.class.get("/rest/kanoahtests/1.0/testcase/#{test_case_id}/attachment", headers: @header).tap do |response|
        #   raise TMJ::TestCaseError, response unless response.code == 201
        # end
      end

      # Create new result for test case
      #
      # @param [Hash] test_data
      #
      # @example
      #   test_data = { project: "GG", test_case: 'GG-T1'}
      #   TMJ::Client.new.TestCase.create_new_test_result(test_data)
      #
      def create_new_test_result(test_data)
        body = process_result(test_data)
        self.class.post('/rest/kanoahtests/1.0/testresult', body: body.to_json, headers: @header).tap do |response|
          raise TMJ::TestCaseError, response unless response.code == 200
        end
      end

      private

      # Creates hash for new test result
      #
      # @param [Hash] test_data
      def process_result(test_data)
        {
          'projectKey'    => test_data.fetch(:project_id, @project_id),
          'testCaseKey'   => test_data[:test_case],
          'status'        => test_data.fetch(:status, nil),
          'environment'   => test_data.fetch(:environment, @environment),
          'userKey'       => test_data.fetch(:username, nil),
          'comment'       => test_data.fetch(:comment, nil),
          'executionTime' => test_data.fetch(:execution_time, nil),
          'executionDate' => test_data.fetch(:execution_date, nil),
          'scriptResults' => test_data.fetch(:script_results, nil)
        }.delete_if { |_k, v| v.nil? }
      end
    end
  end
end
