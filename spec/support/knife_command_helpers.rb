module KnifeCommandHelpers
  def knife_command(cmd_class, *args)
    cmd_class.load_deps
    command = cmd_class.new(args)
    command.ui.stub(:msg)
    command.ui.stub(:err)
    command
  end
end

