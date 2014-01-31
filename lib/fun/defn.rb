module Fun
  module Defn
    def defn(name, &block)
      define_method(name) do |*args|
        function = Fun.fn(&block)
        args.any? ? function[*args] : function
      end
    end
  end
end
