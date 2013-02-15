shared_examples_for "a node command" do
  describe "#search_for_target" do
    it "should search by the args" do
      search_args = %w[search by these args]
      node_command.name_args = search_args
      node_command.stub(search: 'some search result')
      node_command.should_receive(:search).with(search_args)
      node_command.search_for_target.should == 'some search result'
    end

    it "should print error and exit if no results found" do
      node_command.stub(search: nil)
      node_command.ui.should_receive(:error).with("Can't find node. Run `knife sous list` to see nodes")
      lambda { node_command.search_for_target }.should raise_error SystemExit
    end
  end

  describe "#check_args" do
    it "should print error, show usage and exit if no args are passed in" do
      node_command.ui.should_receive(:fatal).with("You need to specificy a node or namespace")
      node_command.should_receive(:show_usage)
      lambda { node_command.check_args}.should raise_error SystemExit
    end
  end

  describe "#run" do
    before do
      node_command.stub(:process_result)
      node_command.stub(:check_args)
      node_command.stub(:search_for_target)
    end

    it "should check that the args exist" do
      node_command.should_receive(:check_args)
      node_command.run
    end

    it "should search for the target" do
      node_command.should_receive(:search_for_target)
      node_command.run
    end

    it "should process result" do
      node_command.stub(search_for_target: "search results")
      node_command.should_receive(:process_result).with("search results")
      node_command.run
    end
  end

  describe "#process_result" do
    it "should run solo_command Node" do
      node = KnifeSous::Node.new('node')
      node_command.should_receive(:solo_command).with(node)
      node_command.process_result(node)
    end

    it "should run solo command on each child if result is a Namespace" do
      namespace = KnifeSous::Namespace.new('namespace')
      namespace << 'child1' << 'child2'
      node_command.should_receive(:solo_command).with('child1')
      node_command.should_receive(:solo_command).with('child2')
      node_command.process_result(namespace)
    end
  end
end

