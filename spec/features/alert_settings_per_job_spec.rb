require 'spec_helper'
require 'minicron/alert'
require 'twilio-ruby'

describe "Alert settings per Job" do

  before(:each) do
    app.new
  end

  context "when the nested options was overridden in the subgroup" do
    let(:smtp_address) { 'example.com' }
    let(:job) { create(:job, alert_options: subgroup_name1) }
    let(:subgroup_name1) { 'name1' }
    let(:subgroup_name2) { 'name2' }

    before(:each) do
      Minicron.config['alerts']['sms']['override'] = { subgroup_name1 => { 'enabled' => true } }
      Minicron.config['alerts']['email']['override'] = {}
      Minicron.config['alerts']['email']['override'][subgroup_name1] = { 'enabled' => true, 'smtp' => { 'address' => smtp_address } }
      Minicron.config['alerts']['email']['override'][subgroup_name2] = { 'enabled' => true }
    end

    it "returns alert option subgroups" do
      alertOptionsSubgroups = {
        alert_options_subgroups: [
          { name: subgroup_name1 },
          { name: subgroup_name2 }
        ]
      }
      get '/api/alertOptionsSubgroups'
      expect(last_response).to be_ok
      expect(last_response.body).to eq alertOptionsSubgroups.to_json
    end

    it "sends message" do
      alert = Minicron::Alert.new
      expect(alert).to receive(:send_sms)

      email = double()
      allow(email).to receive(:get_message)
      allow(email).to receive(:send)
      expect(Minicron::Email).to receive(:new).with({ "enabled" => true, "smtp" => { "address" => smtp_address } }).and_return(email)

      alert.send_all({
        kind: 'fail',
        job_id: job.id
      })
    end
  end
end
