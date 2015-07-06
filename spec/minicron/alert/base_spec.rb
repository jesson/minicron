require 'spec_helper'
require 'minicron/alert/base'

describe Minicron::AlertBase do
  let(:alert_base) { Minicron::AlertBase.new }

  describe '#get_message' do
    context 'when kind is miss' do
      it 'should return the correct message' do
        time = Time.now.utc
        options = {
          :job_id => 1,
          :expected_at => time,
          :execution_id => 2,
          :kind => 'miss'
        }
        message = "minicron alert - job missed!\nJob #1 failed to execute at its expected time: #{time}"

        expect(alert_base.get_message(options)).to eq message
      end
    end

    context 'when kind is fail' do
      it 'should return the correct message' do
        options = {
          :job_id => 1,
          :execution_id => 2,
          :kind => 'fail'
        }
        message = "minicron alert - job failed!\nExecution #2 of Job #1 failed"

        expect(alert_base.get_message(options)).to eq message
      end
    end

    context 'when kind is not supported' do
      it 'should raise an Exception' do
        options = {
          :kind => 'derp'
        }

        expect do
          alert_base.get_message(options)
        end.to raise_error Exception
      end
    end
  end
end
