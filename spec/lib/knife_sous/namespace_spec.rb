require 'spec_helper'

describe KnifeSous::Namespace do
  let(:namespace) { KnifeSous::Namespace.new("some namespace name") }

  it_should_behave_like "a collection object" do
    let(:collection) { namespace }
  end

  it_should_behave_like "a dsl wrapper" do
    let(:klass) { namespace }
  end

  describe "#initialize" do
    it "should set the name" do
      namespace.name.should == 'some namespace name'
    end
  end
end

