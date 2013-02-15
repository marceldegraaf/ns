require 'spec_helper'

describe Ns::Request do

  class Dummy; include Ns::Request; end

  it 'should disable HTTPI logging' do
    HTTPI.should_receive(:log=).with(false)
    class Dummy; include Ns::Request; end
  end

end
