require 'minicron/alert/base'
require 'aws-sdk-core'

module Minicron
  class AwsSns < Minicron::AlertBase
    # Used to set up on the AWS::SNS::Topic
    def initialize config
      @config = config

      # Get an instance of the twilio client
      @client = Aws::SNS::Client.new({
        access_key_id:  @config['access_key_id'],
        secret_access_key:  @config['secret_access_key'],
        region: @config['region']
      })
    end

    # Send an sms alert
    #
    # @param from [String]
    # @param to [String]
    # @param message [String]
    def send(subject, message)
      @client.publish(
        topic_arn: @config['topic_arn'],
        subject: subject,
        message: message
      )
    end
  end
end
