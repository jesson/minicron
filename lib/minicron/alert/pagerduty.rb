require 'minicron/alert/base'
require 'pagerduty'

module Minicron
  # Allows the sending of pagerduty alerts
  class PagerDuty < Minicron::AlertBase
    # Used to set up on the pagerduty client
    def initialize config
      @config = config

      # Get an instance of the Pagerduty client
      @client = ::Pagerduty.new(@config['service_key'])
    end

    # Send a pager duty alert
    #
    # @param title [String]
    # @param message [String]
    def send(title, message)
      @client.trigger(title, :message => message)
    end
  end
end
