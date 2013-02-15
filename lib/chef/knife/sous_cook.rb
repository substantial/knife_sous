require 'chef/knife'
require 'knife_sous/configure_command'
require 'knife_sous/node_command'

class Chef
  class Knife
    class SousCook < Knife
      include KnifeSous::ConfigureCommand
      include KnifeSous::NodeCommand

      deps do
        require 'chef/knife/solo_cook'
      end

      banner "knife sous cook [NAMESPACE] NODE"

      def solo_cook_node(node)
        solo_cook_command = configure_command(Chef::Knife::SoloCook.new, node)
        Chef::Knife::SoloCook.load_deps
        solo_cook_command.name_args << node.hostname
        solo_cook_command.name_args << node.node_config
        solo_cook_command.run
      end

      alias_method :solo_command, :solo_cook_node
    end
  end
end

