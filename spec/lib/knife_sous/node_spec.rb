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

  describe "#chef_node_name" do
    it "should return the node name" do
      node = KnifeSous::Node.new("Node-Fuu")
      node.chef_node_name.should == 'Node-Fuu'
    end
  end

  describe "node configuration" do
    let(:node) { KnifeSous::Node.new("Node-Fuu") }

    NODE_METHODS = %w[node_config ssh_config_file]

    NODE_METHODS.each do |method|
      it "should set the #{method}" do
        node.send(method, 'node config stuff')
        node.send(method).should == 'node config stuff'
      end
    end
  end
end

