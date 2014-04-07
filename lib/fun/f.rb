module Fun
  module F
    class ImplicitArgumentsContext < ProcContext
      NAMES=('a'..'z').to_a

      def initialize(args, block)
        @__args__ = args
        __setup__context__(block)
      end

      def it
        @__args__[0]
      end

      def arg_count
      end

      private

      def respond_to_missing?(name, _)
        NAMES.include?(name.to_s)
      end

      def method_missing(name, *args, &block)
        return @__args__[name.to_s.to_i(36) - 10] if respond_to_missing?(name, true)
        __delegate_to_superself__(name, *args, &block)
      end
    end

    class ImplicitArgumentCounter
      def initialize(block)
        @block = block
      end

      def count
        bytecode = RubyVM::InstructionSequence.disasm(block)
        methods = called_methods(bytecode)
        methods << 'a' if methods.include?('it')
        last_var = ImplicitArgumentsContext::NAMES.reverse.detect{|n| methods.include?(n)}
        index = ImplicitArgumentsContext::NAMES.index(last_var)
        return 0 unless index
        index + 1
      end

      private

      def called_methods(bytecode)
        instructions = bytecode.split("\n").map(&:split)

        sends = instructions.select{|i| i[1] == "send"}
        sends = sends.map{|s| s[2].gsub(':', '').gsub(',', '') }

        simple_sends = instructions.select{|i| i[1] == "opt_send_simple"}
        simple_sends = simple_sends.map{|s| s[2].gsub(/^.*:/, '').gsub(',', '')}

        Set.new(sends + simple_sends)
      end

      def method_call?(code)
        code.first == :opt_send_simple
      end

      attr_reader :block
    end

    def add_implicit_arguments(block)
      function = proc do |*args|
        ImplicitArgumentsContext.new(args, block).__call__
      end

      function.curry(ImplicitArgumentCounter.new(block).count)
    end

    def f(&block)
      add_implicit_arguments(block)
    end
  end

  extend F
end
