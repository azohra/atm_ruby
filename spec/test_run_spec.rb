require 'spec_helper'

RSpec.describe ATM::Services::TestRun do
  let(:client) { ATM::Client.new }
  let(:test_run) { client.TestRun }

  context '#create' do
    it 'successful' do
      VCR.use_cassette 'test_run/create_201' do
        test_run.create({ "name": "Test Run","projectKey": "BBQ"})
        expect(test_run.code).to eql(201)
      end
    end
    
    it '400 error(Some parameters are invalid or not found)' do
      VCR.use_cassette 'test_run/create_400' do
        expect do
          test_run.create({ "name": "Test Run"})
        end.to raise_error(ATM::TestRunError)
      end
    end

    it '401 error(authentication)' do
      VCR.use_cassette 'test_run/create_401' do
        expect do
          test_run.create({ "name": "Test Run"})
        end.to raise_error(ATM::TestRunError)
      end
    end

    it '500 error(unrecognized field)' do
      VCR.use_cassette 'test_run/create_500' do
        expect do
          test_run.create({ "somename": "Test Run","projectKey": "BBQ"})
        end.to raise_error(ATM::TestRunError)
      end
    end
  end

  context '#find' do
    it 'successful' do
      VCR.use_cassette 'test_run/find_200' do
        test_run.find('BBQ-R55')
        expect(test_run.code).to eql(200)
      end
    end

    it '404 error(Test Run not found)' do
      VCR.use_cassette 'test_run/find_404' do
        expect do
          test_run.find('BBQ-R555')
        end.to raise_error(ATM::TestRunError)
      end
    end
  end

  context '#delete' do
    it 'successful' do
      VCR.use_cassette 'test_run/delete_204' do
        test_run.delete('BBQ-R55')
        expect(test_run.code).to eql(204)
      end
    end
  end

  context '#search' do
    it 'successful' do
      VCR.use_cassette 'test_run/search_200' do
        test_run.search('projectKey = "BBQ"')
        expect(test_run.code).to eql(200)
      end
    end
  end

  context '#create_new_test_run_result' do
    it 'successful' do
      VCR.use_cassette 'test_run/create_new_test_run_result_201' do
        test_run.create_new_test_run_result('BBQ-R55', 'BBQ-T417', { "status": "Pass" })
        expect(test_run.code).to eql(201)
      end
    end
  end

  context '#update_last_test_run_result' do
    it 'successful' do
      VCR.use_cassette 'test_run/update_last_test_run_result_201' do
        test_run.update_last_test_run_result('BBQ-R55', 'BBQ-T417', {"status": "Fail"})
        expect(test_run.code).to eql(201)
      end
    end
  end

   it 'retrive test case ids based on user name' do
    VCR.use_cassette 'test_run/retrive_based_on_username' do
      test_run.find('BBQ-R56')
      test_run_data = test_run.response.parsed_response
      expect(client.TestCase.retrive_based_on_username(test_run_data, 'test')).to include('BBQ-T417')
    end         
  end

  it '#process_result' do
    test_data = { status: 'Pass',  environment: 'Desktop',
                  comment: 'Test', username: 'some name',
                  execution_time: 0, execution_date: 0
                }
    final_data = { "status"=>"Pass", "environment"=>"Desktop", "comment"=>"Test", "userKey"=>"some name", "executionTime"=>0, "executionDate"=>0 }            
    expect(test_run.process_result(test_data)).to eql(final_data)
  end
end


