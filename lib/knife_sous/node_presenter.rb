module KnifeSous
  class NodePresenter
    attr_reader :node

    def initialize(node)
      @node = node
    end

    def present
      "#{@node.name}\n"
    end
  end
end
