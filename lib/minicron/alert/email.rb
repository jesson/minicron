require 'minicron/alert/base'
require 'mail'

module Minicron
  # Allows the sending of email alerts
  class Email < Minicron::AlertBase
    # Configure the mail client
    def initialize config
      @config = config

      Mail.defaults do
        delivery_method(
          :smtp,
          :address => @config['smtp']['address'],
          :port => @config['smtp']['port'],
          :domain => @config['smtp']['domain'],
          :user_name => @config['smtp']['user_name'],
          :password => @config['smtp']['password'],
          :enable_starttls_auto => @config['smtp']['enable_starttls_auto']
        )
      end
    end

    # Send an email alert
    #
    # @param from [String]
    # @param to [String]
    # @param subject [String]
    # @param message [String]
    def send(from, to, subject, message)
      Mail.deliver do
        to       to
        from     from
        subject  subject
        body     message
      end
    end
  end
end
