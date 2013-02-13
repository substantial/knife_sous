require 'knife_sous/node'

require 'knife_sous/dsl_definitions'
require 'knife_sous/dsl_wrapper'


module KnifeSous
  class Namespace
    include DSL
    include DSLWrapper

    attr_reader :name

    def initialize(name)
      @name = name.to_s
    end
  end
end

