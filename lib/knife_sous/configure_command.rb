module KnifeSous
  module ConfigureCommand

    def configure_command(command, node)
      node_methods = [:ssh_config_file, :node_config, :chef_node_name]
      node_config = {}

      node_methods.each do |method|
        node_config[method] = node.send(method)
      end

      command.config.merge!(node_config)
      command
    end
  end
end

