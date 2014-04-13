module Fun
  module Fn
    def fn(&block)
      function = Fun.loop_recur(block)
      Fun.auto_curry(function, block.arity)
    end
  end

  extend Fn
end
