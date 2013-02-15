require 'spec_helper'

class DummyCommand < Chef::Knife
end

describe KnifeSous::ConfigureCommand do
  include KnifeCommandHelpers

  describe "#configure_command" do
    it "should be configured for a given node" do
      node = KnifeSous::Node.new('some node',
                                 foo: 'bar',
                                 ssh_password: 'some_password')

      cmd = command
      KnifeSous::ConfigureCommand.configure_command(cmd, node)

      cmd.config[:ssh_password].should == 'some_password'
      cmd.config[:foo].should == 'bar'
    end
  end

  def command(*args)
    knife_command(DummyCommand, *args)
  end
end

