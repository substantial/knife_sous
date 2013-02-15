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
    end
  end
end

