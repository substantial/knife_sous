require 'chef/knife'
require 'knife_sous/processor_command'

class Chef
  class Knife
    class SousInit < Knife
      include KnifeSous::ProcessorCommand

      banner "knife sous init [DIRECTORY]"

      def node_manifest_example_path
        File.expand_path(File.join(File.dirname(__FILE__), '..', '..', 'templates', 'nodes.example.rb'))
      end

      def run
        unless name_args.empty?
          target = File.expand_path(name_args.first)
        else
          target = File.expand_path(Dir.pwd, File.join('nodes'))
        end
        copy_template(target)
      end

      def copy_template(location)
        FileUtils.mkdir_p(location)

        target_file = File.join(location, 'nodes.example.rb' )

        unless File.exists?(target_file)
          FileUtils.cp(node_manifest_example_path, target_file)
          ui.msg "Example nodes.rb copied to #{target_file}"
        else
          ui.error "File already exists: #{target_file}"
        end
      end
    end
  end
end

