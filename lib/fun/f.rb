module Fun
  module F
    class Context < ProcContext
      NAMES=('a'..'z').to_a

      def initialize(args, block)
        @args = args
        __setup__context__(block)
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
        __delegate_to_superself__(name, *args, &block)
      end
    end

    def f(arg_count = nil, &block)
      function = proc do |*args|
        Context.new(args, block).__call__
      end

      arg_count ? function.curry(arg_count) : function
    end
  end

  extend F
end
