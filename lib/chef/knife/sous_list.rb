require 'chef/knife'
require 'knife_sous/processor_command'

class Chef
  class Knife
    class SousList < Knife
      include KnifeSous::ProcessorCommand

      banner "knife sous list"

      def run
        present_nodes
      end

      def present_nodes
        ui.output(nodes.present)
      end
    end
  end
end

