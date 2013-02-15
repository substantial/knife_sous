require 'spec_helper'

describe Chef::Knife::SousInit do
  include KnifeCommandHelpers

  describe "#banner" do
    it "should have display how to use command" do
      command.banner.should == 'knife sous init [DIRECTORY]'
    end
  end

  describe "#copy_template" do
    before do
      FileUtils.stub(:mkdir_p)
    end

    it "should copy template to location if location is empty" do
      cmd = command
      File.stub(exists?: false)
      cmd.stub(node_manifest_example_path: 'example location')

      FileUtils.should_receive(:cp).with('example location', 'some/location/nodes.example.rb')
      cmd.ui.should_receive(:msg).with("Example nodes.rb copied to some/location/nodes.example.rb")

      cmd.copy_template('some/location')
    end

    it "should print an error and shouldn't copy if file already exists at destination" do
      cmd = command
      File.stub(exists?: true)
      FileUtils.should_not_receive(:cp)
      cmd.ui.should_receive(:error).with("File already exists: some/location/nodes.example.rb")
      cmd.copy_template('some/location')
    end
  end

  describe "#run" do
    it "should copy example config to default location, if no location specified" do
      cmd = command
      cmd.should_receive(:copy_template).with(File.expand_path(Dir.pwd, File.join('nodes')))
      cmd.run
    end

    it "should copy the example config to specified location" do
      cmd = command
      cmd.should_receive(:copy_template).with(File.expand_path("some/path"))
      cmd.name_args << 'some/path'
      cmd.run
    end
  end

  def command(*args)
    knife_command(Chef::Knife::SousInit, *args)
  end
end

