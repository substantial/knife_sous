require 'chef/knife'
require 'knife_sous/processor_command'
require 'knife_sous/namespace_presenter'

class Chef
  class Knife
    class SousList < Knife
      include KnifeSous::ProcessorCommand

      banner "knife sous list"

      def run
        present_nodes
      end

      def root_namespace
        @root_namespace ||= process_config
      end

      def present_nodes
        ui.output(KnifeSous::NamespacePresenter.new(root_namespace).present)
      end
    end
  end
end

