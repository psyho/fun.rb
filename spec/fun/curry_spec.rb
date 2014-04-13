require 'spec_helper'

describe Fun::Curry do
  def ac(&block)
    Fun.auto_curry(block)
  end

  describe "auto_curry" do
    it "creates a lambda" do
      sum = ac{|a,b,c| a + b + c}

      expect(sum[1, 2, 3]).to eq(6)
    end

    it "creates an auto-curried lambda" do
      sum = ac{|a,b| a + b}
      inc = sum[1]

      expect(inc[5]).to eq(6)
    end

    it "creates a lambda that can be curried until all arguments are given" do
      join = ac{ |a,b,c,d,e,f,g,h,i,j| [a,b,c,d,e,f,g,h,i,j].join(',') }

      expect(join[1][2,3][][4,5,6][7][8,9,10]).to eq("1,2,3,4,5,6,7,8,9,10")
    end

    it "allows auto-currying lambdas with known arity" do
      varargs = lambda{|*args| args.join(',') }
      join = Fun.auto_curry(varargs, -4) # min 3 arguments

      expect(join[1][2][3]).to eq("1,2,3")
    end

    it "creates an immediately-callable lambda for zero-arg lambdas" do
      foo = ac{:foo}

      expect(foo[]).to eq(:foo)
    end
  end
end
