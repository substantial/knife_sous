require 'spec_helper'

describe Chef::Knife::SousList do
  include KnifeCommandHelpers

  describe "#banner" do
    it "should have display how to use command" do
      command.banner.should == 'knife sous list'
    end
  end

  describe "#run" do
    it "should print out the list nodes" do
      cmd = command
      cmd.should_receive(:print_nodes)
      cmd.run
    end
  end

  def command(*args)
    knife_command(Chef::Knife::SousList, *args)
  end
end

