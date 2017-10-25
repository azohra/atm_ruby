module ATM
  module Helper
    module TestCase
      def retrive_based_on_username(test_run, username)
        test_run['items'].map do |test_case|
          test_case['testCaseKey'] if test_case['userKey'] == username
        end.compact
      end
    end
  end
end