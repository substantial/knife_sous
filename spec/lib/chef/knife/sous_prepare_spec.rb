require 'spec_helper'

describe Chef::Knife::SousPrepare do
  include KnifeCommandHelpers

  describe "#banner" do
    it "should have display how to use command" do
      command.banner.should == 'knife sous prepare [NAMESPACE] NODE'
    end
  end
  it_should_behave_like "a node command" do
    let(:node_command) { command }
  end

  describe "#run" do
  end

  def command(*args)
    knife_command(Chef::Knife::SousPrepare, *args)
  end
end

