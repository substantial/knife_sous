module KnifeSous
  module ConfigureCommand

    module_function

    def configure_command(command, node)
      command.config.merge!(node.config)
      command
    end
  end
end

