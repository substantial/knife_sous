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
      cmd = command
      cmd.ui.should_receive(:fatal).with("You need to specificy a node or namespace")
      cmd.should_receive(:show_usage)
      lambda { cmd.check_args}.should raise_error SystemExit
    end
  end
end

