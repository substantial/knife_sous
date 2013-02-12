require 'spec_helper'

describe KnifeSous::Node do
  describe "#initialize" do
    let(:node_config_block) { Proc.new { 'node config stuff' } }

    it "should set the name that was passed in" do
      KnifeSous::Node.new('Node-Fuu', &node_config_block).name.should == 'Node-Fuu'
    end

    it "should evaluate the the block passed in" do
      KnifeSous::Node.any_instance.should_receive(:instance_eval).with(&node_config_block)
      KnifeSous::Node.new('Node-Fuu', &node_config_block)
    end
  end

  describe "#node_config" do
    it "should set the node_config " do
      node = KnifeSous::Node.new('Node-Fuu') do end
      node.node_config('node config stuff')
      node.node_config.should == 'node config stuff'
    end
  end

  describe "#ssh_config" do
    it "should set the ssh config" do
      node = KnifeSous::Node.new('Node-Fuu') do end
      node.ssh_config('node config stuff')
      node.ssh_config.should == 'node config stuff'
    end
  end
end

