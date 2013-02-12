require 'spec_helper'

class DummyClass
  include KnifeSous::DSL
end

describe KnifeSous::DSL do
  it_should_behave_like "a collection object" do
    let(:collection) { DummyClass.new }
  end

  describe "#namespace" do
    let(:some_block) { Proc.new { 'unicorns' } }
    let(:dummy_class) { DummyClass.new }

    it "should instantiate a Namespace" do
      namespace = KnifeSous::Namespace.new('stuff')
      KnifeSous::Namespace.stub(new: namespace)
      KnifeSous::Namespace.should_receive(:new).with('some name')
      dummy_class.namespace('some name', &some_block)
    end

    it "should have the Namespace instance_eval a passed in block" do
      namespace = KnifeSous::Namespace.new('stuff')
      KnifeSous::Namespace.stub(new: namespace)
      namespace.should_receive(:instance_eval).with(&some_block)
      dummy_class.namespace('some name', &some_block)
    end

    it "should add the Namespace to the collection" do
      dummy_class.namespace('some name', &some_block)
      dummy_class.first.should be_a KnifeSous::Namespace
    end
  end

  describe "#node" do
    let(:some_block) { Proc.new { 'unicorns' } }
    let(:dummy_class) { DummyClass.new }

    it "should instantiate a Node" do
      node = KnifeSous::Node.new('stuff')
      KnifeSous::Node.stub(new: node)
      KnifeSous::Node.should_receive(:new).with('some name', &some_block)
      dummy_class.node('some name', &some_block)
    end

    it "should have the Node instance_eval a passed in block" do
      node = KnifeSous::Node.new('stuff')
      KnifeSous::Node.stub(new: node)
      node.should_receive(:instance_eval).with(&some_block)
      dummy_class.node('some name', &some_block)
    end

    it "should add the Node to the collection" do
      dummy_class.node('some name', &some_block)
      dummy_class.first.should be_a KnifeSous::Node
    end
  end
end

