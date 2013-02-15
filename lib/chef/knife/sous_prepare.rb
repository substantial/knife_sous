require 'chef/knife'
require 'knife_sous/processor_command'
require 'knife_sous/configure_command'
require 'knife_sous/node_command'

class Chef
  class Knife
    class SousPrepare < Knife
      include KnifeSous::ProcessorCommand
      include KnifeSous::ConfigureCommand
      include KnifeSous::NodeCommand

      deps do
        require 'chef/knife/solo_prepare'
      end

      banner "knife sous prepare [NAMESPACE] NODE"

      def solo_prepare_node(node)
        solo_cook_command = configure_command(Chef::Knife::SoloPrepare.new, node)
        Chef::Knife::SoloPrepare.load_deps
        solo_cook_command.name_args << node.hostname
        solo_cook_command.name_args << node.node_config
        solo_cook_command.run
      end

      alias_method :solo_command, :solo_prepare_node
    end
  end
end

