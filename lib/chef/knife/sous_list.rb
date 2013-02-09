require 'chef/knife'

class Chef
  class Knife
    class SousList < Knife
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

