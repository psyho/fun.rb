module Fun
  class ProcContext < BasicObject
    def initialize(block)
      __setup__context__(block)
    end

    def __call__(*args)
      __copy_instance_variables__
      instance_exec(*args, &__block__)
    end

    def method_missing(name, *args, &block)
      __delegate_to_superself__(name, *args, &block)
    end

    private

    def __setup__context__(block)
      @__block__ = block
      @__super_self__ = block.binding.eval("self")
    end

    def __delegate_to_superself__(name, *args, &block)
      @__super_self__.__send__(name, *args, &block)
    end

    def __copy_instance_variables__
      __super_self__.instance_variables.each do |name|
        # there's no instance_variable_set on BasicObject
        instance_eval("#{name} = __super_self__.instance_variable_get(#{name.inspect})")
      end
    end

    attr_reader :__super_self__, :__block__
  end
end
