require 'knife_sous/node_presenter'

module KnifeSous
  class NamespacePresenter
    attr_reader :namespace

    def initialize(namespace)
      @namespace = namespace
    end

    def present
      nodes = @namespace.name
      @namespace.each do |child|
        nodes = "#{nodes} #{presenter(child).present}"
      end
      nodes
    end

    def presenter(item)
      klass = item.is_a?(Node) ? NodePresenter : NamespacePresenter
      klass.new(item)
    end
  end
end

