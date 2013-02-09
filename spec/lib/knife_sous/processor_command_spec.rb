require 'spec_helper'

class DummyCommand < Chef::Knife
  include KnifeSous::ProcessorCommand
end

describe KnifeSous::ProcessorCommand do
  include KnifeCommandHelpers

  let(:processor) { command }

  before do
    processor.stub(:instance_eval)
    File.stub(:read)
  end

  describe "options" do
    it "should set the default node config path" do
      processor.config[:node_config].should == "nodes/nodes.rb"
    end

    it "should replace node config path with option argument" do
      cmd = command("--node-config-file=some/node/thing")
      cmd.config[:node_config].should == "some/node/thing"
    end
  end

  describe "#process_config" do
    it "should validate the config" do
      processor.should_receive(:validate_config)
      processor.process_config
    end

    it "should evalute the config file if config is valid" do
      processor.stub(validate_config: true)
      File.stub(read: 'config contents' )
      processor.should_receive(:instance_eval).with('config contents')
      processor.process_config
    end

    it "shouldn't evaluate the config if it isn't valid" do
      processor.stub(validate_config: false)
      processor.should_not_receive(:instance_eval)
      processor.process_config
    end
  end

  describe "#validate_config" do
    it "should print error if file doesn't exist and return false" do
      File.stub(exists?: false)
      processor.ui.should_receive(:error).with("Can't find some config")
      processor.validate_config("some config").should be_false
    end

    it "should print error if file exists but isn't readable and return false" do
      File.stub(exists?: true)
      File.stub(readable?: false)
      processor.ui.should_receive(:error).with("Can't read some config")
      processor.validate_config("some config").should be_false
    end

    it "should return true if file exists and is readable" do
      File.stub(exists?: true)
      File.stub(readable?: true)
      processor.validate_config("some config").should be_true
    end
  end

  def command(*args)
    knife_command(DummyCommand, *args)
  end
end

