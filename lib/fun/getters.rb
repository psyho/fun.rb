module Fun
  module Getters
    extend Defn

    defn :dot do |name, object|
      object.__send__(name)
    end
  end
end
