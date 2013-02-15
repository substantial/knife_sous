require 'spec_helper'

describe KnifeSous::Namespace do
  let(:namespace) { KnifeSous::Namespace.new("some namespace name") }

  it_should_behave_like "a collection object" do
    let(:collection) { namespace }
  end

  it_should_behave_like "dsl wrapper" do
    let(:klass) { namespace }
  end

  describe "#initialize" do
    it "should set the name" do
      KnifeSous::Namespace.new("some namespace name").name.should == 'some namespace name'
    end

    it "should convert symbols to strings" do
      KnifeSous::Namespace.new(:foo_bar).name.should == 'foo_bar'
    end
  end

  describe "root namespace" do
    it "should instance_eval DSL from file" do
      root_namespace = KnifeSous::Namespace.new('')
      root_namespace.instance_eval do
        namespace :production do |prod|
          prod.node :node_awesome
          prod.namespace :web do |web|
            web.node :web_node
          end
        end
        node :vagrant, node_config: 'nodes/some_node.json', ssh_config: 'vagrant config'
      end

      prod_namespace = root_namespace[0]
      prod_namespace.should be_a KnifeSous::Namespace
      prod_namespace.name.should == 'production'

      vagrant_node = root_namespace[1]
      vagrant_node.should be_a KnifeSous::Node
      vagrant_node.name.should == 'vagrant'

      node_awesome = prod_namespace[0]
      node_awesome.should be_a KnifeSous::Node
      node_awesome.name.should == 'node_awesome'

      web_namespace = prod_namespace[1]
      web_namespace.should be_a KnifeSous::Namespace
      web_namespace.name.should == 'web'

      web_node = web_namespace[0]
      web_node.should be_a KnifeSous::Node
      web_node.name.should == 'web_node'
    end
  end
end

