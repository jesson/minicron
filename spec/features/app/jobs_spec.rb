require 'spec_helper'

describe 'Jobs', type: :feature, js: true do

  before(:each) do
    app.new
  end

  it 'Add New Job' do
    visit '/'
  end
end
