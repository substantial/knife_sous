module KnifeSous
  class Node
    attr_reader :name

    def initialize(name, &block)
      @name = name
      instance_eval &block
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

