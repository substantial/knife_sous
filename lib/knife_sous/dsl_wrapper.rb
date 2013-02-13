module KnifeSous
  module DSLWrapper
    def evaluate_block(&block)
      if block.arity == 1
        block[self]
      else
        instance_eval(&block)
      end
    end
  end
end

