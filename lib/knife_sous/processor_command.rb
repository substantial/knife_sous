module KnifeSous
  module ProcessorCommand
    def self.included(other)
      other.class_eval do
        option :node_config,
          :long        => '--node-config-file NODE_CONFIG_FILE',
          :description => 'Alternate location for node config file',
          :default => File.join("nodes", "nodes.rb")
      end
    end

    def validate_config!
      unless File.exists?(config_file_path)
        ui.fatal("Couldn't find #{config_file_path}")
        exit 1
      end
      unless File.readable?(config_file_path)
        ui.fatal("Can't read #{config_file_path}")
        exit 1
      end
      true
    end

    def config_file_path
      @config_file_path ||= File.expand_path(File.join(Dir.pwd, config[:node_config]))
    end

    def process_config
      validate_config!
      instance_eval File.read(config_file_path)
    end
  end
end

