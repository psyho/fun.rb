module Fun
  module Getters
    extend Defn

    defn :dot do |name, object|
      object.__send__(name)
    end

    is_a = Fun.fn{|klass, obj| obj.is_a?(klass)}

    any_pred = proc do |*predicates|
      proc{|*args| predicates.any?{|p| p[*args]}}
    end

    parse_args = Fun.fn do |predicate, matching, other|
      matching, other = other, matching unless predicate[matching]
      [matching, other]
    end

    parse_key_args = parse_args[any_pred[is_a[Symbol], is_a[String]]]

    defn :key do |key, hash|
      key, hash = parse_key_args[key, hash]
      hash && hash[key]
    end

    defn :get do |key, hash|
      key, hash = parse_key_args[key, hash]
      key = key.to_sym
      Fun.key[key, hash] || Fun.key[key.to_s, hash]
    end

    defn :nth do |idx, arr|
      idx, arr = parse_args[is_a[Fixnum], idx, arr]
      arr[idx]
    end
  end

  extend Getters
end
