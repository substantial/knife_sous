require 'spec_helper'

describe KnifeSous::NamespacePresenter do
  describe "#initialize" do
    it "should keep track of the namespace" do
      namespace = 'namespace'
      KnifeSous::NamespacePresenter.new(namespace).namespace.should == 'namespace'
    end
  end

  describe "#present" do
    it "should present its own name" do
      namespace = KnifeSous::Namespace.new("some namespace")
      KnifeSous::NamespacePresenter.new(namespace).present.should == "some namespace"
    end

    it "should present each of its children" do
      namespace = KnifeSous::Namespace.new("foo")
      nested_namespace = KnifeSous::Namespace.new("bar")
      nested_namespace << KnifeSous::Node.new("baz")
      namespace << nested_namespace
      KnifeSous::NamespacePresenter.new(namespace).present.should == "foo bar baz\n"
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
end

