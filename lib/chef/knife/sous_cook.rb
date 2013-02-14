require 'chef/knife'
require 'knife_sous/processor_command'

class Chef
  class Knife
    class SousCook < Knife
      include KnifeSous::ProcessorCommand

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
        solo_cook_command = Chef::Knife::SoloCook.new
        solo_cook_command.config[:ssh_config] = node.ssh_config
        solo_cook_command.config[:node_config] = node.node_config
        solo_cook_command.config[:chef_node_name] = node.name
        solo_cook_command.name_args << node.name
        solo_cook_command.run
      end

      def search_for_target
        result = search(name_args)
        if result.nil?
          ui.error "Can't find node. Run `knife sous list` to see nodes"
          exit 1
        end
        result
      end

      def check_args
        unless name_args.size > 0
          ui.fatal "You need to specificy a node or namespace"
          show_usage
          exit 1
        end
      end
    end
  end
end

