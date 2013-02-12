require 'knife_sous/node'

require 'knife_sous/dsl_definitions'


module KnifeSous
  class Namespace
    include DSL

    attr_reader :name

    def initialize(name)
      @name = name
    end
  end
end

