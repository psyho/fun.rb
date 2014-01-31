module Fun
  module Getters
    extend Defn

    defn :dot do |name, object|
      object.__send__(name)
    end

    defn :key do |key, hash|
      hash && hash[key]
    end

    defn :get do |key, hash|
      key = key.to_sym
      Fun.key[key, hash] || Fun.key[key.to_s, hash]
    end

    defn :nth do |idx, arr|
      arr[idx]
    end
  end

  extend Getters
end
