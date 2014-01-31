module Fun
  module Defn
    def defn(name, &block)
      define_method(name) do |*args|
        Fun.fn(&block)[*args]
      end
    end
  end
end
