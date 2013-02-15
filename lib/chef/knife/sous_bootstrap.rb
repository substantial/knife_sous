require 'chef/knife'
require 'knife_sous/processor_command'
require 'knife_sous/configure_command'
require 'knife_sous/node_command'

class Chef
  class Knife
    class SousBootstrap < Knife
      include KnifeSous::ProcessorCommand
      include KnifeSous::ConfigureCommand
      include KnifeSous::NodeCommand

      deps do
        require 'chef/knife/solo_bootstrap'
      end

      banner "knife sous bootstrap [NAMESPACE] NODE"

      def solo_bootstrap_node(node)
        solo_bootstrap_command = configure_command(Chef::Knife::SoloBootstrap.new, node)
        Chef::Knife::SoloBootstrap.load_deps
        solo_bootstrap_command.name_args << node.hostname
        solo_bootstrap_command.name_args << node.node_config
        solo_bootstrap_command.run
      end

      alias_method :solo_command, :solo_bootstrap_node
    end
  end
end

