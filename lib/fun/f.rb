module Fun
  module F
    class ImplicitArgumentsContext < ProcContext
      NAMES=('a'..'z').to_a

      NAMES.each_with_index do |name, idx|
        define_method name do
          args[idx]
        end
      end

      def initialize(args, block)
        @__args__ = args
        __setup__context__(block)
      end

      def it
        args[0]
      end

      def args
        @__args__
      end
    end

    class ImplicitArgumentCounter
      def initialize(block)
        @block = block
      end

      def count
        bytecode = RubyVM::InstructionSequence.disasm(block)
        methods = called_methods(bytecode)
        return -1 if varargs?(methods)
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

      def varargs?(methods)
        methods.include?('args')
      end

      attr_reader :block
    end

    def add_implicit_arguments(block)
      function = lambda do |*args|
        ImplicitArgumentsContext.new(args, block).__call__
      end

      Fun.auto_curry(function, ImplicitArgumentCounter.new(block).count)
    end

    def f(&block)
      add_implicit_arguments(block)
    end
  end

  extend F
end
