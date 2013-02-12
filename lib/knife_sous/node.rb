require 'knife_sous/dsl_wrapper'

module KnifeSous
  class Node
    include DSLWrapper

    attr_reader :name

    def initialize(name)
      @name = name.to_s
    end

    def present
      "#{@name}\n"
    end

    def node_config(*args)
      if args.length == 1
        @node_config = args.first
      else
        @node_config
      end
    end

    def ssh_config(*args)
      if args.length == 1
        @ssh_config = args.first
      else
        @ssh_config
      end
    end
  end
end

