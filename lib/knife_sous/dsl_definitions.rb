require 'knife_sous/namespace'
require 'knife_sous/node'

module KnifeSous
  module DSL
    def self.included(base)
      base.class_eval do
        base.extend Forwardable
        def_delegators :children, :<<, :first, :last, :[], :map, :each, :to_a, :keep_if, :empty?
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

    def node(name, args={})
      node = Node.new(name, args)
      children << node
    end
  end
end

