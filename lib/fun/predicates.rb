module Fun
  module Predicates
    extend Defn

    defn :is_a do |klass, obj|
      obj.is_a?(klass)
    end
  end

  extend Predicates
end
