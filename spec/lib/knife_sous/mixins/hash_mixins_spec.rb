require 'spec_helper'

describe KnifeSous::HashMixins do

  subject { KnifeSous::HashMixins }

  describe "#sanitize_key"do
    it "should return a lowercase, snake_case, symbol" do
      subject.sanitize_key('SoMEthing-Ridic_uLous!').should == :something_ridic_ulous!
    end
  end

  describe "#normalize_keys" do
    it "should sanitize each keys for a hash" do
      subject.normalize_keys('GroS-key' => 'foo', OtherKey: 'bar').should == {
        gros_key: 'foo', otherkey: 'bar' }
    end
  end
end

