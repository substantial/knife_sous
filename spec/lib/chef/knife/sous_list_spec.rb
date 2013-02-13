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
      cmd.should_receive(:present_nodes)
      cmd.run
    end
  end

  describe "#present_nodes" do
    it "should output presented nodes" do
      cmd = command
      cmd.stub(root_namespace: 'fake root namespace')
      presenter = mock('presenter')
      presenter.stub(present: 'pretty, presented nodes')
      KnifeSous::NamespacePresenter.stub(new: presenter)
      KnifeSous::NamespacePresenter.should_receive(:new).with('fake root namespace')
      cmd.ui.should_receive(:output).with('pretty, presented nodes')
      cmd.present_nodes
    end
  end

  def command(*args)
    knife_command(Chef::Knife::SousList, *args)
  end
end

