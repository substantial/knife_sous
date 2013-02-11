require 'knife_sous/namespace'
require 'knife_sous/node'

module KnifeSous
  class NamespaceBuilder

    def initialize(parent, name, &block)
      @namespace = Namespace.new(name)
      @parent = parent
      @parent << @namespace
      instance_eval &block
    end

    def namespace(name, &block)
      NamespaceBuilder.new(@parent, name, &block)
    end

    def node(name, &block)
      @namespace << Node.new(name, &block)
    end
  end
end

