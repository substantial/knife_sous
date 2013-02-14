require 'spec_helper'

class DummyCommand < Chef::Knife
  include KnifeSous::ConfigureCommand
end

describe KnifeSous::ConfigureCommand do
  include KnifeCommandHelpers


  describe "#configure_command" do
    it "should be configured for a given node" do
      node = KnifeSous::Node.new('some_node')
      node.evaluate_block do |n|
        n.ssh_config 'ssh config'
        n.node_config 'node config'
      end

      other_command = command
      command.configure_command(other_command, node)

      other_command.config[:ssh_config].should == 'ssh config'
      other_command.config[:node_config].should == 'node config'
      other_command.config[:chef_node_name].should == 'some_node'
    end
  end

  def command(*args)
    knife_command(DummyCommand, *args)
  end
end

