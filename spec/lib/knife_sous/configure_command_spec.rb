require 'spec_helper'

class DummyCommand < Chef::Knife
  include KnifeSous::ConfigureCommand
end

describe KnifeSous::ConfigureCommand do
  include KnifeCommandHelpers


  describe "#configure_command" do
    let(:node) { KnifeSous::Node.new('some node') }

    describe "#node_name" do
      it "should set the node name" do
        node.evaluate_block do
          node_name :node_tastic
        end
        node.node_name.should == 'node_tastic'
      end

      it "should default to the node name" do
        node.node_name.should == 'some node'
      end
    end

    it "should be configured for a given node" do
      node.evaluate_block do |n|
        n.ssh_config_file 'ssh config'
        n.node_config 'node config'
        n.ssh_user 'some_user'
        n.ssh_port 22
        n.identity_file 'path/to/iden/file'
        n.ssh_password 'some_password'
      end

      other_command = command
      command.configure_command(other_command, node)

      other_command.config[:ssh_config_file].should == 'ssh config'
      other_command.config[:node_config].should == 'node config'
      other_command.config[:ssh_port].should == '22'
      other_command.config[:identity_file].should == 'path/to/iden/file'
      other_command.config[:ssh_user].should == 'some_user'
      other_command.config[:ssh_password].should == 'some_password'
    end
  end


  def command(*args)
    knife_command(DummyCommand, *args)
  end
end

