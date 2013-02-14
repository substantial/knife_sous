require 'knife_sous/dsl_wrapper'

module KnifeSous
  class Node
    include DSLWrapper

    attr_reader :name

    METHOD_NAMES = %w[node_config ssh_config_file ssh_port ssh_user identity_file hostname user]

    def initialize(name)
      @name = name.to_s
    end

    def chef_node_name
      @name
    end

    METHOD_NAMES.each do |method|
      instance_var = "@#{method}".to_sym
      define_method method do |arg = nil|
        unless arg.nil?
          instance_variable_set(instance_var, arg)
        else
          instance_variable_get(instance_var)
        end
      end
    end
  end
end

