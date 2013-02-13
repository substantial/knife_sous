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
end

