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
      @config.merge!(normalize_hash(other_config))
    end

    def node_name
      @config[:node_name] || @name
    end

    def method_missing(method_name, *args, &block)
      @config[method_name.to_sym]
    end
  end
end

