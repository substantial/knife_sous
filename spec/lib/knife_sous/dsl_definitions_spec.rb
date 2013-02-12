require 'spec_helper'

class DummyClass
  include KnifeSous::DSL
  def initialize
    initialize_children
  end
end

describe KnifeSous::DSL do
  let(:dummy_class) { DummyClass.new }

  describe "Extending class" do
    it "should add @children to instance_variables" do
      dummy_class.instance_variables.should include :@children
    end

    it "should allow adding and retreiving objects from the class" do
      dummy_class << 'foo'
      dummy_class.first.should == 'foo'
    end

    it "should allow direct lookup of element" do
      dummy_class << 'foo' << 'bar'
      dummy_class[0].should == 'foo'
      dummy_class[1].should == 'bar'
    end
  end

  [KnifeSous::Node, KnifeSous::Namespace].each do |klass|
    describe klass do
      let(:some_block) { Proc.new { 'unicorns' } }
      let(:method_name) { klass.to_s.split('::').last.downcase }

      it "should instantiate a #{klass}" do
        # test= KnifeSous::Namespace.new('stuff')
        # KnifeSous::Namespace.stub(new: namespace)
        # KnifeSous::Namespace.should_receive(:new).with('some name')
        # dummy_class.namespace('some name', &some_block)
      end

      it "should have the #{klass} instance_eval a passed in block" do
        test_klass = klass.new('stuff')
        klass.stub(new: test_klass)
        test_klass.should_receive(:instance_eval).with(&some_block)
        dummy_class.send(method_name,'some name', &some_block)
      end

      it "should add the #{klass} to the children" do
        dummy_class.send(method_name, 'some name', &some_block)
        dummy_class.first.should be_a klass
      end
    end
  end
end

