require 'spec_helper'

describe KnifeSous::Node do
  describe "#initialize" do
    it "should set the name that was passed in" do
      KnifeSous::Node.new('Node-Fuu').name.should == 'Node-Fuu'
    end

    it "should convert symbols to strings" do
      KnifeSous::Node.new(:node_tastic).name.should == 'node_tastic'
    end
  end

  it_should_behave_like "dsl wrapper" do
    let(:klass) { KnifeSous::Node.new('Node-Fuu') }
  end
end

