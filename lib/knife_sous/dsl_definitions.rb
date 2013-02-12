module KnifeSous
  module DSL

    def self.included(base)
      base.class_eval do
        base.extend Forwardable
        def_delegators :children, :<<, :first, :[], :map, :each, :to_a
      end
    end

    def children
      @children ||= []
    end

    def namespace(name, &block)
      namespace = Namespace.new(name)
      namespace.instance_eval(&block)
      children << namespace
    end

    def node(name, &block)
      node = Node.new(name)
      node.instance_eval(&block)
      children << node
    end
  end
end

