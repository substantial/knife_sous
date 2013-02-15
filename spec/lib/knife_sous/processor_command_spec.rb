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
      processor.default_config[:node_manifest_file].should == "nodes/nodes.rb"
    end

    it "should replace node config path with option argument" do
      cmd = command("--node-manifest-file=some/node/thing")
      cmd.config[:node_manifest_file].should == "some/node/thing"
    end
  end

  describe "#process_config" do
    let(:namespace) { KnifeSous::Namespace.new('root') }

    before do
      KnifeSous::Namespace.stub(new: namespace )
      namespace.stub(:instance_eval)
    end

    it "should validate the config" do
      processor.should_receive(:validate_config!)
      processor.process_config
    end

    it "should create and return root namespace and evaluate the config if file is valid" do
      processor.stub(:validate_config!)
      File.stub(read: 'config contents' )
      processor.stub(manifest_file_path: 'some config path' )
      namespace.should_receive(:instance_eval).with('config contents', 'some config path')

      processor.process_config.should be_a KnifeSous::Namespace
    end
  end

  describe "#validate_config" do
    it "should print error and exit if file doesn't exist" do
      File.stub(exists?: false)
      processor.stub(manifest_file_path: 'some config path' )
      processor.ui.should_receive(:fatal).with("Couldn't find some config path")
      lambda { processor.validate_config! }.should raise_error SystemExit
    end

    it "should print error if file exists but isn't readable and return false" do
      File.stub(exists?: true)
      File.stub(readable?: false)
      processor.stub(manifest_file_path: 'some config path' )
      processor.ui.should_receive(:fatal).with("Can't read some config path")
      lambda { processor.validate_config! }.should raise_error SystemExit
    end

    it "should return true if file exists and is readable" do
      File.stub(exists?: true)
      File.stub(readable?: true)
      processor.validate_config!.should be_true
    end
  end

  describe "#manfiest_file_patch" do
    it "should return the full path to the config file" do
      processor.manifest_file_path.should == File.expand_path(File.join(Dir.pwd, 'nodes', 'nodes.rb' ))
    end
  end

  describe "#root_namespace" do
    it "should process_config" do
      processor.should_receive(:process_config)
      processor.root_namespace
    end
  end

  describe "#search" do
    let(:root_namespace) { KnifeSous::Namespace.new("root_namespace") }
    let(:nodeA) { KnifeSous::Node.new("nodeA") }

    before do
      processor.stub(root_namespace: root_namespace)
    end

    it "should return the target" do
      root_namespace << nodeA
      processor.search(%w[nodeA]).should == nodeA
    end

    it "should return a namespace if target" do
      foo_space = KnifeSous::Namespace.new("foo")
      bar_space = KnifeSous::Namespace.new("bar")
      baz_space = KnifeSous::Namespace.new("baz")
      root_namespace << foo_space
      foo_space << bar_space
      bar_space << baz_space
      processor.search(%w[foo bar baz]).should == baz_space
    end

    context do
      before do
        other_namespace = KnifeSous::Namespace.new("other_namespace")
        other_namespace << nodeA
        root_namespace << other_namespace
      end

      it "shouldn't return nodes, unless fully qualified" do
          processor.search(%w[nodeA other_namespace]).should == nil
      end

      it "shouldn't return nodes, unless fully qualified" do
          processor.search(%w[nodeA]).should == nil
      end

      it "should require qualified namespaces" do
        processor.search(%w[other_namespace nodeA]).should == nodeA
      end
    end
  end

  def command(*args)
    knife_command(DummyCommand, *args)
  end
end

