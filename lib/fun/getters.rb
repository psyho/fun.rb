module Fun
  module Getters
    extend Defn

    defn :dot do |name, object|
      object.__send__(name)
    end

    defn :key do |symbol, hash|
      hash, symbol = symbol, hash if hash.is_a?(Symbol) || hash.is_a?(String)
      hash && hash[symbol]
    end
  end
end
