require 'spec_helper'

describe KnifeSous::NodePresenter do
  describe "#initialize" do
    it "should keep track of the node" do
      node = 'node'
      KnifeSous::NodePresenter.new(node).node.should == 'node'
    end
  end

  describe "#present" do
    it "should present the node name and a newline" do
      node = KnifeSous::Node.new('Awesome node')
      KnifeSous::NodePresenter.new(node).present.should == "Awesome node\n"
    end
  end
end

