require 'spec_helper'


def command(*args)
  cmd = knife_command(Chef::Knife::SousList, *args)
end

describe Chef::Knife::SousList do
  include KnifeCommandHelpers

  describe "#banner" do
    it "should have display how to use command" do
      command.banner.should == 'knife sous list'
    end
  end
end

