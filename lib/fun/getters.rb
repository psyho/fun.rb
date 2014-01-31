module Fun
  module Getters
    extend Defn

    defn :dot do |name, object|
      object.__send__(name)
    end

    parse_key_args = proc do |key, hash|
      hash, key = key, hash if hash.is_a?(Symbol) || hash.is_a?(String)
      [hash, key]
    end

    defn :key do |key, hash|
      hash, key = parse_key_args[key, hash]
      hash && hash[key]
    end

    defn :get do |key, hash|
      hash, key = parse_key_args[key, hash]
      key = key.to_sym
      Fun.key[key, hash] || Fun.key[key.to_s, hash]
    end
  end
end
