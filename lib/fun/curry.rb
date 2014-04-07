module Fun
  module Curry
    def auto_curry(block, arity = nil)
      arity ||= block.arity
      arity = arity.abs - 1 if arity < 0
      block.curry(arity)
    end
  end

  extend Curry
end
