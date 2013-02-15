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

