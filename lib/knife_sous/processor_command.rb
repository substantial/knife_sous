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

    def validate_config(config_file_path)
      unless File.exists?(config_file_path)
        ui.error("Can't find #{config_file_path}")
        return false
      end
      unless File.readable?(config_file_path)
        ui.error("Can't read #{config_file_path}")
        return false
      end
      true
    end

    def process_config
      config_file_path = File.expand_path(File.join(Dir.pwd, config[:node_config]))
      instance_eval File.read(config_file_path) if validate_config(config_file_path)
    end
  end
end

