require 'spec_helper'
require 'minicron/alert/pagerduty'

describe Minicron::PagerDuty do
  let(:config) { Minicron.config['alerts']['pagerduty'] }
  let(:pagerduty) { Minicron::PagerDuty.new config }

  describe '#intiailize' do
    it 'should create an instance of the Pagerduty gem' do
      expect(pagerduty.instance_variable_get(:@client)).to be_a Pagerduty
    end
  end

  describe '#send' do
    it 'should trigger an alert on the pagerduty client' do
      expect(pagerduty.instance_variable_get(:@client)).to receive(:trigger).with('title', :message => 'yo')

      pagerduty.send('title', 'yo')
    end
  end
end
