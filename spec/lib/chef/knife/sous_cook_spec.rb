require 'spec_helper'

describe Chef::Knife::SousCook do
  include KnifeCommandHelpers

  describe "#banner" do
    it "should have display how to use command" do
      command.banner.should == 'knife sous cook [NAMESPACE] NODE'
    end
  end

  it_should_behave_like "a node command" do
    let(:node_command) { command }
  end

  describe "#solo_cook_node" do
    let(:node) { KnifeSous::Node.new('nodetastic') }
    let(:cmd) { command }
    let(:solo_cook_command) { Chef::Knife::SoloCook.new }

    before do
      Chef::Knife::SoloCook.stub(new: solo_cook_command)
      solo_cook_command.stub(:run)
      cmd.stub(configure_command: solo_cook_command)
      node.update_config(
        node_config: '/path/to/node/config',
        hostname: 'host_ip'
      )
    end

    it "should provide name to args and run" do
      solo_cook_command.should_receive(:run)
      cmd.solo_cook_node(node)

      solo_cook_command.name_args.should == %w[host_ip /path/to/node/config]
    end
  end

  def command(*args)
    knife_command(Chef::Knife::SousCook, *args)
  end
end

