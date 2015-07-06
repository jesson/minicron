class Minicron::Hub::App
  # Get all alerts
  get '/api/alertOptionsSubgroups' do
    content_type :json
    subgroups = []
    Minicron.config['alerts'].each do |key, value|
      if value.has_key?('override')
        value['override'].each do |key2, value2|
          subgroups.push({ name: key2 })
        end
      end
    end
    { alert_options_subgroups: subgroups.uniq }.to_json
  end
end
