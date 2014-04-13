module Fun
  class ProcContext
    def initialize(block)
      __setup__context__(block)
    end

    def __call__(*args)
      __copy_instance_variables__
      __call_block__(*args)
    end

    def method_missing(name, *args, &block)
      __delegate_to_superself__(name, *args, &block)
    end

    def to_proc
      method(:__call__).to_proc
    end

    private

    def __setup__context__(block)
      @__block__ = block
      @__super_self__ = block.binding.eval("self")
      define_singleton_method(:__call_block__, &block)
    end

    def __delegate_to_superself__(name, *args, &block)
      @__super_self__.__send__(name, *args, &block)
    end

    def __copy_instance_variables__
      __super_self__.instance_variables.each do |name|
        instance_variable_set(name, __super_self__.instance_variable_get(name))
      end
    end

    attr_reader :__super_self__, :__block__
  end
end
