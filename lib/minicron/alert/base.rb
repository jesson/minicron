module Minicron
  class AlertBase
    # Return the message for an alert
    #
    # @option options [Minicron::Hub::Job] job a job instance
    # @option options [String] kind 'fail' or 'miss'
    # @option options [Integer, nil] schedule_id only applies to 'miss' alerts
    # @option options [Integer, nil] execution_id only used by 'fail' alerts
    # @option options [Integer] job_id used to look up the job name for the alert message
    # @option options [Time] expected_at when the schedule was expected to execute
    # @option options [String] medium the medium to send the alert via
    def get_message(options = {})
      case options[:kind]
      when 'miss'
        "minicron alert - job missed!\nJob ##{options[:job_id]} failed to execute at its expected time: #{options[:expected_at]}"
      when 'fail'
        "minicron alert - job failed!\nExecution ##{options[:execution_id]} of Job ##{options[:job_id]} failed"
      else
        fail Exception, "The kind '#{options[:kind]} is not supported!"
      end
    end

  end
end
