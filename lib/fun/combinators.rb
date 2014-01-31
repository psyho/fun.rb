module Fun
  module Combinators
    extend Defn

    defn :any_pred do |*predicates|
      proc{|*args| predicates.any?{|p| p[*args]}}
    end
  end

  extend Combinators
end
