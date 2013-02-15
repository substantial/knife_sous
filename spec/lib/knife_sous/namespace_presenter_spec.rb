require 'spec_helper'

describe KnifeSous::NamespacePresenter do
  describe "#initialize" do
    it "should keep track of the namespace" do
      namespace = 'namespace'
      KnifeSous::NamespacePresenter.new(namespace).namespace.should == 'namespace'
    end
  end

  describe "#presenter" do
    it "should return a NodePresenter if item is a Node" do
      root_namespace_presenter = KnifeSous::NamespacePresenter.new('foo namespace')
      some_node = KnifeSous::Node.new('some node')
      root_namespace_presenter.presenter(some_node).should be_a KnifeSous::NodePresenter
    end

    it "should return a NamespacePresenter if item is a Namespace" do
      root_namespace_presenter = KnifeSous::NamespacePresenter.new('foo namespace')
      some_namespace = KnifeSous::Namespace.new('some node')
      root_namespace_presenter.presenter(some_namespace).should be_a KnifeSous::NamespacePresenter
    end
  end

  describe "#present" do
    it "should present its own name" do
      namespace = KnifeSous::Namespace.new("some namespace")
      KnifeSous::NamespacePresenter.new(namespace).present.should == "some namespace"
    end

    it "should present each of its children" do
      root_namespace = KnifeSous::Namespace.new("")
      namespaceA = KnifeSous::Namespace.new(:namespace_a)
      namespaceB = KnifeSous::Namespace.new(:namespace_b)

      node1 = KnifeSous::Node.new(:node_1)
      node2 = KnifeSous::Node.new(:node_2)
      node3 = KnifeSous::Node.new(:node_3)
      node4 = KnifeSous::Node.new(:node_4)

      root_namespace << namespaceA
      namespaceA << node1
      namespaceA << node2
      namespaceA << namespaceB
      namespaceB << node3
      root_namespace << node4

      KnifeSous::NamespacePresenter.new(root_namespace).present.should ==<<-TEXT
namespace_a node_1
namespace_a node_2
namespace_a namespace_b node_3
node_4
TEXT
    end
  end
end

