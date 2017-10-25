require 'spec_helper'

RSpec.describe ATM::Services::TestPlan do
  let(:client)    { ATM::Client.new }
  let(:test_case) { client.TestCase }

  context '#create' do
    it 'successful' do
      VCR.use_cassette 'test_case/create_201' do
        test_case.create({"projectKey": "CC", "name": "Ensure the axial-flow pump is enabled"})
        expect(test_case.code).to eql(201)
      end
    end

    it '500 error(unrecognized field)' do
      VCR.use_cassette 'test_case/create_500' do
        expect do
          test_case.create({"projectKey": "CC", "somename": "Ensure the axial-flow pump is enabled"})
        end.to raise_error(ATM::TestCaseError)
      end
    end

    it '400 error(Some parameters are invalid or not found)' do
      VCR.use_cassette 'test_case/create_400' do
        expect do
          test_case.create({"name": "Ensure the axial-flow pump is enabled"})
        end.to raise_error(ATM::TestCaseError)
      end
    end
  end

  context '#update' do
    it 'successful' do
      VCR.use_cassette 'test_case/update_200' do
        test_case.update('CC-T2774', { "name": "Ensure the axial-flow pump is disabled"})
        expect(test_case.code).to eql(200)
      end
    end
  end

  context '#delete' do
    it 'successful' do
      VCR.use_cassette 'test_case/delete_204' do
        test_case.delete('CC-T2774')
        expect(test_case.code).to eql(204)
      end
    end
  end

  context '#find' do
    it 'successful' do
      VCR.use_cassette 'test_case/find_200' do
        test_case.find('CC-T2774')
        expect(test_case.code).to eql(200)
      end
    end

    it '404 error' do
      VCR.use_cassette 'test_case/find_404' do
        expect do
          test_case.find('CC-T277492')
        end.to raise_error(ATM::TestCaseError)
      end
    end

    it '401 error(authentication)' do
      VCR.use_cassette 'test_case/find_401' do
        expect do
          test_case.find('CC-T2774')
        end.to raise_error(ATM::TestCaseError)
      end
    end
  end

  context '#search' do
    it 'successful' do
      VCR.use_cassette 'test_case/search_200' do
        test_case.search('projectKey = "BB"')
        expect(test_case.code).to eql(200)
      end
    end
  end

  context '#create_new_test_result' do
    it 'successful' do
      VCR.use_cassette 'test_case/new_test_result_200' do
        test_case.create_new_test_result({"projectKey": "CC", "testCaseKey": "CC-T2774", "status": "Pass"})
        expect(test_case.code).to eql(200)
      end
    end
  end

  it '#process_result' do
    test_data = { project_id: 'DD', test_case: 'DD-T1', 
                  status: 'Passed', environment: 'mobile', 
                  comment: 'comment', execution_time: 0, execution_date: 0 }
    final_data = {"projectKey"=>"DD", "testCaseKey"=>"DD-T1",
                  "status"=>"Passed", "environment"=>"mobile",
                  "comment"=>"comment","executionTime"=>0,"executionDate"=>0}              
    expect(test_case.process_result(test_data)).to eql(final_data)
  end
end