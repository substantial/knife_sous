require 'spec_helper'

describe KnifeSous::Namespace do
  describe "#initialize" do
    let(:namespace) { KnifeSous::Namespace.new("some namespace name") }
    it "should set the name" do
      namespace.name.should == 'some namespace name'
    end

    it "should allow the use of the << operator, like an Array" do
      namespace << 'some stuff'
      namespace.first.should == 'some stuff'
    end

    it "should allow accessing its children by index" do
      namespace << 'some text' << "other stuff"
      namespace[0].should == 'some text'
      namespace[1].should == 'other stuff'
    end
  end
end

