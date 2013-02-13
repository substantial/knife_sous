require 'spec_helper'

describe Chef::Knife::SousCook do
  include KnifeCommandHelpers

  describe "#banner" do
    it "should have display how to use command" do
      command.banner.should == 'knife sous cook [NAMESPACE] NODE'
    end
  end

  def command(*args)
    knife_command(Chef::Knife::SousCook, *args)
  end
end

