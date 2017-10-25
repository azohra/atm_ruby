require 'spec_helper'

RSpec.describe ATM::Services::TestPlan do
  let(:valid_test_plan_id)   { 'CC-P9' }
  let(:client) { ATM::Client.new }

  it 'successfully retried' do
    VCR.use_cassette 'test_plan/200' do
      test_plan = client.TestPlan.find(valid_test_plan_id)
      expect(test_plan.code).to eq 200
    end
  end

  it 'not found based on provided key' do
    VCR.use_cassette 'test_plan/404' do    
      expect { client.TestPlan.find('CC-P90') }.to raise_error(ATM::TestPlanError)
    end
  end

  it 'authentication error' do
    VCR.use_cassette 'test_plan/401' do
      expect { client.TestPlan.find(valid_test_plan_id) }.to raise_error(ATM::TestPlanError)
    end
  end

  it 'internal server error' do
    VCR.use_cassette 'test_plan/500' do  
      expect { client.TestPlan.find(valid_test_plan_id) }.to raise_error(ATM::TestPlanError)
    end
  end
end
