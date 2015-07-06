if ENV['CI'] && (!defined?(RUBY_ENGINE) || RUBY_ENGINE == 'ruby')
  require 'coveralls'
  Coveralls.wear!
end

require 'simplecov'
SimpleCov.start do
  add_filter '/spec/'
end

require 'rack/test'
require 'rspec'
require 'minicron'
require 'minicron/cli'
require 'minicron/hub/app'
require 'faker'
require 'database_cleaner'

ENV['RACK_ENV'] = 'test'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

RSpec.configure do |config|
  include Rack::Test::Methods

  config.color = true
  config.formatter     = 'documentation'

  # Taken from commander gem
  # prevent paging from actually occurring in test environment
  config.before(:each) do
    allow(Commander::UI).to receive(:enable_paging)
  end

  def app
    Minicron::Hub::App
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end

# Configure Minicron Db
Minicron.config['database']['type'] = 'mysql'
Minicron.config['database']['host'] = 'localhost'
Minicron.config['database']['database'] = 'minicron_test'
Minicron.config['database']['username'] = 'minicron_test'
Minicron.config['database']['password'] = 'minicron_test'

Minicron::Hub::App.setup_db
unless ActiveRecord::Base.connection.table_exists? 'jobs'
  Sinatra::ActiveRecordTasks.db_dir = Minicron::HUB_PATH + '/db'
  Rake.application['db:schema:load'].invoke
end

# Normalise varied new line usage
class String
  def clean
    strip.gsub(/\r\n?/, "\n")
  end
end
