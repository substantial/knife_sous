require 'forwardable'

module KnifeSous
  class Namespace
    extend Forwardable

    attr_reader :name
    def_delegators :@children, :<<, :map, :each, :first, :[]

    def initialize(name)
      @name = name
      @children = []
    end
  end
end

