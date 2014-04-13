module Fun
  module LoopRecur
    class InvalidRecur < StandardError
    end

    class Recur
      attr_reader :args

      def initialize(args)
        @args = args
      end

      def method_missing(name, *args, &block)
        raise InvalidRecur, "recur must be the last instruction in the function/tloop!"
      end

      def self.recur?(object)
        object.is_a?(self)
      end
    end

    class LoopRecurDecorator < ProcContext
      def tloop(&block)
        @__has_loop__ = true
        define_singleton_method(:__call_loop__, &block)
        recur
      end

      def recur(*args)
        Recur.new(args)
      end

      def __call__(*args)
        result = super
        while Recur.recur?(result)
          result = __recur__(*result.args)
        end
        result
      end

      private

      def __recur__(*args)
        if @__has_loop__
          __call_loop__(*args)
        else
          __call_block__(*args)
        end
      end
    end

    def loop_recur(block)
      lambda do |*args|
        LoopRecurDecorator.new(block).__call__(*args)
      end
    end
  end

  extend LoopRecur
end
