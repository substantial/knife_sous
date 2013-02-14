require 'knife_sous/namespace'

module KnifeSous
  module ProcessorCommand
    def self.included(other)
      other.class_eval do
        option :node_manifest_file,
          :long        => '--node-manifest-file NODE_MANIFEST_FILE',
          :description => 'Alternate location for node manifest config file',
          :default => File.join("nodes", "nodes.rb")
      end
    end

    def validate_config!
      unless File.exists?(manifest_file_path)
        ui.fatal("Couldn't find #{manifest_file_path}")
        exit 1
      end
      unless File.readable?(manifest_file_path)
        ui.fatal("Can't read #{manifest_file_path}")
        exit 1
      end
      true
    end

    def search(target_qualifiers = [])
      namespace = root_namespace
      target_qualifiers.each do |target_qualifier|
        return nil if namespace.nil?
        namespace = namespace.keep_if { |item| item.name == target_qualifier }.first
      end
      namespace
    end

    def root_namespace
      @root_namespace ||= process_config
    end

    def manifest_file_path
      config[:node_manifest_file] ||= default_config[:node_manifest_file]
      @manifest_file_path ||= File.expand_path(File.join(Dir.pwd, config[:node_manifest_file]))
    end

    def process_config
      validate_config!
      root_namespace = Namespace.new('')
      root_namespace.instance_eval(File.read(manifest_file_path))
      root_namespace
    end
  end
end

