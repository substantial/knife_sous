require 'chef/knife'
require 'knife_sous/processor_command'

class Chef
  class Knife
    class SousCook < Knife
      include KnifeSous::ProcessorCommand

      banner "knife sous cook NODE"

      def run
        unless name_args.size == 1
          puts "You need to say specificy a node or namespace"
          show_usage
          exit 1
        end
        target = name_args.first
        # result = search(target)
      end
    end
  end
end

