module KnifeSous
  module ConfigureCommand

    def configure_command(command, node)
      node_config = {
        ssh_config_file: node.ssh_config_file,
        node_config: node.node_config,
        chef_node_name: node.name
      }
      command.config.merge!(node_config)
      command
    end
  end
end

