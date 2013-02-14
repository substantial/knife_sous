module KnifeSous
  module ConfigureCommand

    def configure_command(command, node)
      command.config.merge!(node.config)
      command
    end
  end
end

