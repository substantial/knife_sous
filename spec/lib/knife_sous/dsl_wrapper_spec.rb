require 'spec_helper'

class DummyClass
  include KnifeSous::DSLWrapper
  attr_reader :foo
  def set_foo (name)
    @foo = name
  end
end

describe KnifeSous::DSLWrapper do
  let(:dummy_class) { DummyClass.new }

  describe "#evaluate_block" do
    it "should execute blocks in the class' context" do
      test_block = Proc.new { set_foo 'bar'}
      dummy_class.evaluate_block(&test_block)
      dummy_class.foo.should == 'bar'
    end

    it "should support passing itself in as the context" do
      test_block = Proc.new { |i| i.set_foo 'bar'}
      dummy_class.evaluate_block(&test_block)
      dummy_class.foo.should == 'bar'
    end
  end
end

