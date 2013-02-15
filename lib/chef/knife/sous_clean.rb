require 'chef/knife'
require 'knife_sous/processor_command'
require 'knife_sous/configure_command'
require 'knife_sous/node_command'

class Chef
  class Knife
    class SousClean < Knife
      include KnifeSous::ProcessorCommand
      include KnifeSous::ConfigureCommand
      include KnifeSous::NodeCommand

      deps do
        require 'chef/knife/solo_clean'
      end

      banner "knife sous clean [NAMESPACE] NODE"

      def solo_clean_node(node)
        solo_cook_command = configure_command(Chef::Knife::SoloClean.new, node)
        Chef::Knife::SoloClean.load_deps
        solo_cook_command.name_args << node.hostname
        solo_cook_command.run
      end

      alias_method :solo_command, :solo_clean_node
    end
  end
end

