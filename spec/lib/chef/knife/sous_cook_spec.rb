require 'spec_helper'

describe Chef::Knife::SousCook do
  include KnifeCommandHelpers

  describe "#banner" do
    it "should have display how to use command" do
      command.banner.should == 'knife sous cook [NAMESPACE] NODE'
    end
  end

  describe "#check_args" do
    it "should print error, show usage and exit if no args are passed in" do
      cmd = command
      cmd.ui.should_receive(:fatal).with("You need to specificy a node or namespace")
      cmd.should_receive(:show_usage)
      lambda { cmd.check_args}.should raise_error SystemExit
    end
  end

  describe "#search_for_target" do
    it "should search by the args" do
      search_args = %w[search by these args]
      cmd = command(*search_args)
      cmd.stub(search: 'some search result')
      cmd.should_receive(:search).with(search_args)
      cmd.search_for_target.should == 'some search result'
    end

    it "should print error and exit if no results found" do
      cmd = command
      cmd.stub(search: nil)
      cmd.ui.should_receive(:error).with("Can't find node. Run `knife sous list` to see nodes")
      lambda { cmd.search_for_target }.should raise_error SystemExit
    end
  end

  describe "#run" do
    let(:cmd) { command }

    before do
      cmd.stub(:cook_target)
    end

    it "should check that the args exist" do
      cmd.stub(:search_for_target)
      cmd.should_receive(:check_args)
      cmd.run
    end

    it "should search for the target" do
      cmd.stub(:check_args)
      cmd.should_receive(:search_for_target)

      cmd.run
    end

    it "should perform Knife Solo Cook on search result" do
      cmd.stub(:check_args)
      cmd.stub(search_for_target: "search results")
      cmd.should_receive(:cook_target).with("search results")
      cmd.run
    end
  end

  describe "#cook_target" do
    it "should cook target if its a Node" do
      node = KnifeSous::Node.new('node')
      cmd = command
      cmd.should_receive(:solo_cook_node).with(node)
      cmd.cook_target(node)
    end

    it "should cook each child if target is Namespace" do
      cmd = command
      namespace = KnifeSous::Namespace.new('namespace')
      namespace << 'child1' << 'child2'
      cmd.should_receive(:solo_cook_node).with('child1')
      cmd.should_receive(:solo_cook_node).with('child2')
      cmd.cook_target(namespace)
    end
  end

  describe "#solo_cook_node" do
    let(:node) { KnifeSous::Node.new('nodetastic') }
    let(:cmd) { command }
    let(:solo_cook_command) { Chef::Knife::SoloCook.new }

    before do
      Chef::Knife::SoloCook.stub(new: solo_cook_command)
      solo_cook_command.stub(:run)
    end

    it "should instantiate a Solo Cook command" do
      Chef::Knife::SoloCook.should_receive(:new)
      cmd.solo_cook_node(node)
    end

    it "should configure the Solo Cook command" do
      node.stub(ssh_config: 'node ssh_config')
      node.stub(node_config: 'node config')

      solo_cook_command.should_receive(:run)
      cmd.solo_cook_node(node)

      solo_cook_command.name_args.should == %w[nodetastic]
      solo_cook_command.config[:ssh_config].should == 'node ssh_config'
      solo_cook_command.config[:node_config].should == 'node config'
      solo_cook_command.config[:chef_node_name].should == 'nodetastic'
    end
  end

  def command(*args)
    knife_command(Chef::Knife::SousCook, *args)
  end
end

