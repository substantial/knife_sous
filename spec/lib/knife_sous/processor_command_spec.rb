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
    let(:namespace) { KnifeSous::Namespace.new('root') }

    before do
      namespace.stub(:instance_eval)
      KnifeSous::Namespace.stub(new: namespace )
    end

    it "should validate the config" do
      processor.should_receive(:validate_config!)
      processor.process_config
    end

    it "should create and return root namespace and evaluate the config if file is valid" do
      processor.stub(:validate_config!)
      File.stub(read: 'config contents' )
      namespace.should_receive(:instance_eval).with('config contents')

      root_namespace = processor.process_config
      root_namespace.should be_a KnifeSous::Namespace
      root_namespace.name.should == 'root'
    end
  end

  describe "#validate_config" do
    it "should print error and exit if file doesn't exist" do
      File.stub(exists?: false)
      processor.stub(config_file_path: 'some config path' )
      processor.ui.should_receive(:fatal).with("Couldn't find some config path")
      lambda { processor.validate_config! }.should raise_error SystemExit
    end

    it "should print error if file exists but isn't readable and return false" do
      File.stub(exists?: true)
      File.stub(readable?: false)
      processor.stub(config_file_path: 'some config path' )
      processor.ui.should_receive(:fatal).with("Can't read some config path")
      lambda { processor.validate_config! }.should raise_error SystemExit
    end

    it "should return true if file exists and is readable" do
      File.stub(exists?: true)
      File.stub(readable?: true)
      processor.validate_config!.should be_true
    end
  end

  describe "#config_file_path" do
    it "should return the full path to the config file" do
      processor.config_file_path.should == File.expand_path(File.join(Dir.pwd, 'nodes', 'nodes.rb' ))
    end
  end

  def command(*args)
    knife_command(DummyCommand, *args)
  end
end

