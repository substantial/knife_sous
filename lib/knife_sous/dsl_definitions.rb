require 'knife_sous/namespace'
require 'knife_sous/node'

module KnifeSous
  module DSL
    def self.included(base)
      base.class_eval do
        base.extend Forwardable
        def_delegators :children, :<<, :first, :[], :map, :each, :to_a, :select, :select!, :keep_if, :empty?
      end
    end

    def children
      @children ||= []
    end

    def namespace(name, &block)
      namespace = Namespace.new(name)
      namespace.evaluate_block(&block)
      children << namespace
    end

    def node(name, &block)
      node = Node.new(name)
      node.evaluate_block(&block)
      children << node
    end
  end
end

