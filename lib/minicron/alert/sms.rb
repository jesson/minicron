require 'minicron/alert/base'
require 'twilio-ruby'

module Minicron
  # Allows the sending of SMS alerts via Twilio
  class SMS < Minicron::AlertBase
    # Used to set up on the twilio client
    def initialize config
      @config = config

      # Get an instance of the twilio client
      @client = Twilio::REST::Client.new(
        @config['twilio']['account_sid'],
        @config['twilio']['auth_token']
      )
    end

    # Send an sms alert
    #
    # @param from [String]
    # @param to [String]
    # @param message [String]
    def send(from, to, message)
      @client.account.messages.create(
        :from => from,
        :to => to,
        :body => message
      )
    end
  end
end
