require 'knife_sous/node_presenter'

module KnifeSous
  class NamespacePresenter
    attr_reader :namespace

    def initialize(namespace)
      @namespace = namespace
    end

    def present
      return @namespace.name if @namespace.empty?

      nodes = ""
      @namespace.each do |child|
        nodes << "#{@namespace.name} #{presenter(child).present}".lstrip
      end
      nodes
    end

    def presenter(item)
      klass = item.is_a?(Node) ? NodePresenter : NamespacePresenter
      klass.new(item)
    end
  end
end

