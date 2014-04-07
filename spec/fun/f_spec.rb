require 'spec_helper'

describe "f{}" do
  it "creates procs" do
    foo = f{:foo}

    expect(foo[]).to eq(:foo)
  end

  it "names the first passed argument 'it'" do
    inc = f{it+1}

    expect(inc[7]).to eq(8)
  end

  it "names the arguments a, b, c, etc." do
    sum = f{a+b+c}

    expect(sum[1,2,3]).to eq(6)
  end

  let(:world) { "World" }
  it "allows the function to refer to the methods from original context" do
    greet = f{ "Hello, #{world}!" }

    expect(greet[]).to eq("Hello, World!")
  end

  it "allows the function to refer to instance variables from original context" do
    greet = f{ "Hello, #{@world}!" }

    @world = "World"
    expect(greet[]).to eq("Hello, World!")
  end

  it "creates a curriable function if number of arguments is passed" do
    sum = f(3){a+b+c}

    expect(sum[1][2][3]).to eq(6)
  end
end
