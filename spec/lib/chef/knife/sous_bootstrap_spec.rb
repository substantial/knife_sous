require 'spec_helper'

describe Chef::Knife::SousBootstrap do
  include KnifeCommandHelpers

  describe "#banner" do
    it "should have display how to use command" do
      command.banner.should == 'knife sous bootstrap [NAMESPACE] NODE'
    end
  end
  it_should_behave_like "a node command" do
    let(:node_command) { command }
  end

  describe "#solo_bootstrap_node" do
    let(:node) { KnifeSous::Node.new('nodetastic') }
    let(:cmd) { command }
    let(:solo_bootstrap_command) { Chef::Knife::SoloBootstrap.new }

    before do
      Chef::Knife::SoloBootstrap.stub(new: solo_bootstrap_command)
      solo_bootstrap_command.stub(:run)
      cmd.stub(configure_command: solo_bootstrap_command)
      node.update_config(
        node_config: '/path/to/node/config',
        hostname: 'host_ip'
      )
    end

    it "should provide name to args and run" do
      solo_bootstrap_command.should_receive(:run)
      cmd.solo_bootstrap_node(node)

      solo_bootstrap_command.name_args.should == %w[host_ip /path/to/node/config]
    end
  end

  def command(*args)
    knife_command(Chef::Knife::SousBootstrap, *args)
  end
end

