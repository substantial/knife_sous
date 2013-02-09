require 'chef/knife'
require 'knife_sous/processor_command'

class Chef
  class Knife
    class SousList < Knife
      include KnifeSous::ProcessorCommand

      banner "knife sous list"

      def run
        print_nodes
      end

      def print_nodes
        nodes.each do |node|
          ui.msg node.name
        end
      end

      def nodes

      end
    end
  end
end

