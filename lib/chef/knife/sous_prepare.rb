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

      def run
        check_args
        search_result = search_for_target
        prepare_target(search_result)
      end

      def prepare_target(target)
        if target.is_a? KnifeSous::Namespace
          target.each do |item|
            prepare_target(item)
          end
        else
          solo_prepare_node(target)
        end
      end

      def solo_prepare_node(node)
        solo_cook_command = configure_command(Chef::Knife::SoloPrepare.new, node)
        Chef::Knife::SoloPrepare.load_deps
        solo_cook_command.name_args << node.hostname
        solo_cook_command.name_args << node.node_config
        solo_cook_command.run
      end
    end
  end
end

