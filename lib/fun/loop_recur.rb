module Fun
  module LoopRecur
    class Recur
      attr_reader :args

      def initialize(args)
        @args = args
      end

      def self.recur?(object)
        object.is_a?(self)
      end
    end

    class LoopRecurDecorator < ProcContext
      def tloop(&block)
        @__loop__ = block
        recur
      end

      def recur(*args)
        Recur.new(args)
      end

      def __call__(*args)
        result = super
        while Recur.recur?(result)
          result = instance_exec(*result.args, &__loop__)
        end
        result
      end

      private

      def __loop__
        @__loop__ || __block__
      end
    end

    def tfn(&block)
      proc do |*args|
        LoopRecurDecorator.new(block).__call__(*args)
      end
    end
  end

  extend LoopRecur
end
