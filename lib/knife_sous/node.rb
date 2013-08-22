require 'knife_sous/dsl_wrapper'
require 'knife_sous/mixins/hash_mixins'

module KnifeSous
  class Node
    include KnifeSous::HashMixins

    attr_reader :name, :config

    def initialize(name, config_args={})
      @name = name.to_s
      @config = {}
      update_config(config_args)
    end

    def update_config(other_config={})
      config = convert_aliases(normalize_hash(other_config))
      @config[:chef_node_name] = @name
      @config.merge!(config)
    end

    def convert_aliases(config_hash = {})
      config_aliases.each do |key, value|
        if config_hash.has_key?(key)
          config_hash[value] = config_hash[key]
          config_hash.delete(key)
        end
      end
      config_hash
    end

    def method_missing(method_name, *args, &block)
      @config[method_name.to_sym]
    end

    def config_aliases
      {
        ssh_config_file: :ssh_config,
        ip: :hostname
      }
    end
  end
end

