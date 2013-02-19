require 'spec_helper'

describe Ns::Station do

  subject { Ns::Station.new(name: 'edc') }

  it 'should have a name' do
    subject.name.should == 'edc'
  end

end
