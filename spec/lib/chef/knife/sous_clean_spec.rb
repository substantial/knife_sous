require 'spec_helper'

describe Chef::Knife::SousClean do
  include KnifeCommandHelpers

  describe "#banner" do
    it "should have display how to use command" do
      command.banner.should == 'knife sous clean [NAMESPACE] NODE'
    end
  end
  it_should_behave_like "a node command" do
    let(:node_command) { command }
  end

  describe "#solo_clean_node" do
    let(:node) { KnifeSous::Node.new('nodetastic') }
    let(:cmd) { command }
    let(:solo_clean_command) { Chef::Knife::SoloClean.new }

    before do
      Chef::Knife::SoloClean.stub(new: solo_clean_command)
      solo_clean_command.stub(:run)
      cmd.stub(configure_command: solo_clean_command)
      node.update_config(
        hostname: 'host_ip'
      )
    end

    it "should provide name to args and run" do
      solo_clean_command.should_receive(:run)
      cmd.solo_clean_node(node)

      solo_clean_command.name_args.should == %w[host_ip]
    end
  end

  def command(*args)
    knife_command(Chef::Knife::SousClean, *args)
  end
end

