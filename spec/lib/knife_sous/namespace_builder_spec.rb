require 'spec_helper'

describe KnifeSous::NamespaceBuilder do
  let(:parent) { [] }

  describe "#initialize" do
    let(:test_block) { Proc.new { 'some stuff' } }

    it "should instantiate a Namespace" do
      KnifeSous::Namespace.should_receive(:new).with('Foo bar bazboon')
      KnifeSous::NamespaceBuilder.new(parent, 'Foo bar bazboon', &test_block)
    end

    it "should add namespace to the parent" do
      namespace = mock('namespace')
      KnifeSous::Namespace.stub(new: namespace)
      KnifeSous::NamespaceBuilder.new(parent, 'Foo bar', &test_block)
      parent.should include namespace
    end

    it "should evaluate the the block passed in" do
      KnifeSous::NamespaceBuilder.any_instance.should_receive(:instance_eval).with(&test_block)
      KnifeSous::NamespaceBuilder.new(parent, 'Foo bar', &test_block)
    end
  end

  describe "#namespace" do
    let(:test_block) { Proc.new { 'some stuff' } }

    it "should instantiate a new instance of NamespaceBuilder" do
      initial_builder = KnifeSous::NamespaceBuilder.new(parent, 'Foo bar') do end
      KnifeSous::NamespaceBuilder.should_receive(:new).with(parent, 'namefoo', &test_block)
      initial_builder.namespace('namefoo', &test_block)
    end
  end

  describe "#node" do
    let(:node_config_block) { Proc.new { 'node config stuff' }}
    let(:builder) { KnifeSous::NamespaceBuilder.new(parent, 'Foo bar') do end }

    it "should instantiate a Node" do
      KnifeSous::Node.should_receive(:new).with('some node', &node_config_block)
      builder.node("some node", &node_config_block)
    end

    it "should add the Node to the namespace" do
      namespace = []
      node = mock('node')
      KnifeSous::Namespace.stub(new: namespace)
      KnifeSous::Node.stub(new: node)
      builder.node("some node", &node_config_block)
      namespace.should include node
    end
  end
end

