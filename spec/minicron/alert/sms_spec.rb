require 'spec_helper'
require 'minicron/alert/sms'

describe Minicron::SMS do
  let(:config) { Minicron.config['alerts']['sms'] }

  before (:each) do
    Minicron.parse_config_hash({
      'alerts' => {
        'sms' => {
          'twilio' => {
            'account_sid' => 'abc123',
            'auth_token' => 'abc456'
          }
        }
      }
    })
  end

  describe '#intiailize' do
    it 'should create an instance of the Twilio gem' do
      sms = Minicron::SMS.new config

      expect(sms.instance_variable_get(:@client)).to be_a Twilio::REST::Client
    end
  end

end
