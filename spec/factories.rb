FactoryGirl.define do

  factory :host, class: "Minicron::Hub::Host" do
    fqdn { Faker::Internet.domain_name }
    user { Faker::Internet.user_name }
    host { Faker::Internet.domain_name }
    port { 22 }
  end

  factory :job, class: "Minicron::Hub::Job" do
    host
    user { Faker::Internet.user_name }
    command { Faker::Lorem.word }
  end

end
