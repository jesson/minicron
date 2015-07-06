require 'spec_helper'
require 'minicron/alert/aws_sns'

describe Minicron::AwsSns do

  before (:each) do
    Minicron.parse_config_hash({
      'alerts' => {
        'aws_sns' => {
          'secret_access_key' => 'jiuwmEf91KWMqzsUlV/xzuDku7otULnAmm7v/bSM',
          'access_key_id' => 'AKIAJMUAH24YJW6BCX2Q',
          'region' => 'us-west-2',
          'topic_arn' => 'arn:aws:sns:us-west-2:453856305308:minicron-test'
        }
      }
    })
    @config = Minicron.config['alerts']['aws_sns']
  end

  describe '#intiailize' do
    it 'should create an instance of the Twilio gem' do
      sns = Minicron::AwsSns.new @config

      expect(sns.instance_variable_get(:@client)).to be_a Aws::SNS::Client
    end
  end

  describe '#send' do
    it 'sends message to the topic_arn' do
      sns = Minicron::AwsSns.new @config
      subject = 'subject'
      message = 'message'
      expect_any_instance_of(Aws::SNS::Client).to receive(:publish).with(
        topic_arn: Minicron.config['alerts']['aws_sns']['topic_arn'],
        subject: subject,
        message: message
      )

      sns.send(subject, message)
    end
  end

end
