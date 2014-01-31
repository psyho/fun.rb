module Fun
  module Fn
    def fn(&block)
      block.curry
    end
  end
end
