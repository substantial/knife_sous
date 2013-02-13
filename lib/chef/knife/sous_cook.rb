require 'chef/knife'
require 'knife_sous/processor_command'

class Chef
  class Knife
    class SousCook < Knife
      include KnifeSous::ProcessorCommand

      banner "knife sous cook [NAMESPACE] NODE"

      def run
        unless name_args.size > 0
          puts "You need to specificy a node or namespace"
          show_usage
          exit 1
        end
        result = search(name_args)
      end
    end
  end
end

