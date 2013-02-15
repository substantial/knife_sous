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

    it "should perform Knife Solo Prepare on search result" do
      cmd.stub(:check_args)
      cmd.stub(search_for_target: "search results")
      cmd.should_receive(:prepare_target).with("search results")
      cmd.run
    end
  end

  describe "#prepare_target" do
    let(:cmd) { command }
    it "should prepare target if its a Node" do
      node = KnifeSous::Node.new('node')
      cmd.should_receive(:solo_prepare_node).with(node)
      cmd.prepare_target(node)
    end

    it "should prepare each child if target is Namespace" do
      namespace = KnifeSous::Namespace.new('namespace')
      namespace << 'child1' << 'child2'
      cmd.should_receive(:solo_prepare_node).with('child1')
      cmd.should_receive(:solo_prepare_node).with('child2')
      cmd.prepare_target(namespace)
    end
  end

  describe "#solo_prepare_node" do
    let(:node) { KnifeSous::Node.new('nodetastic') }
    let(:cmd) { command }
    let(:solo_prepare_command) { Chef::Knife::SoloPrepare.new }

    before do
      Chef::Knife::SoloPrepare.stub(new: solo_prepare_command)
      solo_prepare_command.stub(:run)
      cmd.stub(configure_command: solo_prepare_command)
      node.update_config(
        node_config: '/path/to/node/config',
        hostname: 'host_ip'
      )
    end

    it "should provide name to args and run" do
      solo_prepare_command.should_receive(:run)
      cmd.solo_prepare_node(node)

      solo_prepare_command.name_args.should == %w[host_ip /path/to/node/config]
    end
  end

  def command(*args)
    knife_command(Chef::Knife::SousPrepare, *args)
  end
end

