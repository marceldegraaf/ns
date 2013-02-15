require 'spec_helper'

describe Ns do

  let(:configuration) { Ns::Configuration.new }

  it 'should have a version' do
    Ns::VERSION.should_not be_nil
  end

  it 'should be configurable' do
    Ns.configure do |config|
      config.username = 'john'
      config.password = 'secret'
    end

    Ns.configuration.username.should == 'john'
    Ns.configuration.password.should == 'secret'
  end

end
