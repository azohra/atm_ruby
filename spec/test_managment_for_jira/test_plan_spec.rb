require 'spec_helper'

describe TMJ::Services::TestPlan do
  let(:valid_test_plan_id)   { 'JQA-P123' }
  let(:invalid_test_plan_id) { 'JQA-P124' }
  let(:client) { TMJ::Client.new }

  it 'the test plan was successfully retrived' do
    stub_request(:get, TMJ.config.base_url + '/rest/kanoahtests/1.0/testplan/JQA-P123')
      .to_return(status: 200, body: get_mock_response('test_plan/JQA-P123.json'))
    test_plan = client.TestPlan.find(valid_test_plan_id)
    expect(test_plan.response.code).to eq '200'
  end

  it 'no test plan has been found with the given key' do
    stub_request(:get, TMJ.config.base_url + '/rest/kanoahtests/1.0/testplan/JQA-P124')
      .to_return(status: 404, body: '')
    expect { client.TestPlan.find(invalid_test_plan_id) }.to raise_error(TMJ::TestPlanError)
  end
  
  it 'authentication error' do
    stub_request(:get, TMJ.config.base_url + '/rest/kanoahtests/1.0/testplan/JQA-P123')
      .to_return(status: 401, body: '')
    expect { client.TestPlan.find(valid_test_plan_id) }.to raise_error(TMJ::TestPlanError)
  end
end
