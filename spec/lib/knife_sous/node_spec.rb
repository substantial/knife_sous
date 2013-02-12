require 'spec_helper'

describe KnifeSous::Node do
  describe "#initialize" do
    it "should set the name that was passed in" do
      KnifeSous::Node.new('Node-Fuu').name.should == 'Node-Fuu'
    end
  end

  describe "#node_config" do
    it "should set the node_config " do
      node = KnifeSous::Node.new('Node-Fuu')
      node.node_config('node config stuff')
      node.node_config.should == 'node config stuff'
    end
  end

  describe "#ssh_config" do
    it "should set the ssh config" do
      node = KnifeSous::Node.new('Node-Fuu')
      node.ssh_config('node config stuff')
      node.ssh_config.should == 'node config stuff'
    end
  end
end

