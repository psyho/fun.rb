require 'spec_helper'

describe "fn{}" do
  it "creates a proc" do
    sum = fn{|a,b,c| a + b + c}

    expect(sum[1, 2, 3]).to eq(6)
  end

  it "creates an auto-curried proc" do
    sum = fn{|a,b| a + b}
    inc = sum[1]

    expect(inc[5]).to eq(6)
  end

  it "creates a proc that can be curried until all arguments are given" do
    join = fn{ |a,b,c,d,e,f,g,h,i,j| [a,b,c,d,e,f,g,h,i,j].join(',') }

    expect(join[1][2,3][][4,5,6][7][8,9,10]).to eq("1,2,3,4,5,6,7,8,9,10")
  end

  it "creates an immediately-callable proc for zero-arg procs" do
    foo = fn{:foo}

    expect(foo[]).to eq(:foo)
  end
end
