module KnifeSous
  module DSLWrapper
    def evaluate_block(&block)
      yield self if block_given?
    end
  end
end

