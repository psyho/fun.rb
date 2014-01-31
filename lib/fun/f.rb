module Fun
  module F
    class Context < BasicObject
      NAMES=('a'..'z').to_a

      def initialize(args, binding)
        @args = args
        @super_self = binding.eval("self")
      end

      def it
        @args[0]
      end

      private

      def respond_to_missing?(name, _)
        NAMES.include?(name.to_s)
      end

      def method_missing(name, *args, &block)
        return @args[name.to_s.to_i(36) - 10] if respond_to_missing?(name, true)
        @super_self.__send__(name, *args, &block)
      end
    end

    def f(arg_count = nil, &block)
      function = proc do |*args|
        Context.new(args, block.binding).instance_eval(&block)
      end

      arg_count ? function.curry(arg_count) : function
    end
  end

  extend F
end
