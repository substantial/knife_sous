require 'knife_sous/dsl_wrapper'

module KnifeSous
  class Node
    include DSLWrapper

    attr_reader :name

    CONFIG_OPTIONS = %w[node_config ssh_config_file ssh_port ssh_user
identity_file hostname user ssh_password]

    def initialize(name)
      @name = name.to_s
    end

    def node_name(arg = nil)
      unless arg.nil?
        @node_name = arg.to_s
      else
        @node_name || @name
      end
    end

    CONFIG_OPTIONS.each do |method|
      instance_var = "@#{method}".to_sym
      define_method method do |arg = nil|
        unless arg.nil?
          instance_variable_set(instance_var, arg.to_s)
        else
          instance_variable_get(instance_var)
        end
      end
    end
  end
end

