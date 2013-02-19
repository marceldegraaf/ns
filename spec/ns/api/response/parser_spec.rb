require 'spec_helper'

describe Ns::Api::Response::Parser do

  let(:xml) { File.read(File.join($ROOT, 'spec/fixtures/ns_travel_advice_response.xml')) }
  subject   { Ns::Api::Response::Parser.new(response_text: xml) }

  it 'should have a parser' do
    Nori.should_receive(:new)
    subject.send(:parser)
  end

  it 'should parse a response' do
    subject.parsed_response.class.should == Hash
  end

end
