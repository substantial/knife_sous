require 'chef/knife'
require 'knife_sous/processor_command'
require 'knife_sous/configure_command'
require 'knife_sous/node_command'

class Chef
  class Knife
    class SousCook < Knife
      include KnifeSous::ProcessorCommand
      include KnifeSous::ConfigureCommand
      include KnifeSous::NodeCommand

      deps do
        require 'chef/knife/solo_cook'
      end

      banner "knife sous cook [NAMESPACE] NODE"

      def run
        check_args
        search_result = search_for_target
        cook_target(search_result)
      end

      def cook_target(target)
        if target.is_a? KnifeSous::Namespace
          target.each do |item|
            cook_target(item)
          end
        else
          solo_cook_node(target)
        end
      end

      def solo_cook_node(node)
        solo_cook_command = configure_command(Chef::Knife::SoloCook.new, node)
        Chef::Knife::SoloCook.load_deps
        solo_cook_command.name_args << node.hostname
        solo_cook_command.name_args << node.node_config
        solo_cook_command.run
      end
    end
  end
end

