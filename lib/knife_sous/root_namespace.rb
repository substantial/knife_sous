require 'knife_sous/node'

require 'knife_sous/dsl_definitions'
require 'knife_sous/dsl_wrapper'


module KnifeSous
  class RootNamespace < Namespace
    def initialize
      @name = ""
    end
  end
end

