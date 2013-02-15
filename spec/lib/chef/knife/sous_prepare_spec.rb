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
    let(:cmd) { command }
    before do
      cmd.stub(:prepare_target)
    end

    it "should check that the args exist" do
      cmd.stub(:search_for_target)
      cmd.should_receive(:check_args)
      cmd.run
    end

    it "should search for the target" do
      cmd.stub(:check_args)
      cmd.should_receive(:search_for_target)

      cmd.run
    end

    it "should perform Knife Solo Cook on search result" do
      cmd.stub(:check_args)
      cmd.stub(search_for_target: "search results")
      cmd.should_receive(:prepare_target).with("search results")
      cmd.run
    end
  end

  def command(*args)
    knife_command(Chef::Knife::SousPrepare, *args)
  end
end

