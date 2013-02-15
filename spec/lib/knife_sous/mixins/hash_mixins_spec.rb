require 'spec_helper'

describe KnifeSous::HashMixins do

  subject { KnifeSous::HashMixins }

  describe "#sanitize_key"do
    it "should return a lowercase, snake_case, symbol" do
      subject.sanitize_key('SoMEthing-Ridic_uLous!').should == :something_ridic_ulous!
    end
  end

  describe "#normalize_hash" do
    it "should sanitize each key" do
      subject.normalize_hash('GroS-key' => 'foo', OtherKey: 'bar').keys.should =~ [:gros_key, :otherkey]
    end

    it "should convert every value to string" do
      subject.normalize_hash(number: 5, bar: 'baz').should == { number: '5', bar: 'baz' }
    end
  end
end

