require 'chef/knife'
require 'knife_sous/processor_command'

class Chef
  class Knife
    class SousList < Knife
      include KnifeSous::ProcessorCommand

      banner "knife sous list"

      def run
        ui.output(nodes)
      end

      def nodes
        @nodes ||= process_config
      end
    end
  end
end

