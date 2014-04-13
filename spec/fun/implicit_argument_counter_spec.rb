require 'spec_helper'

describe Fun::F::ImplicitArgumentCounter do
  def arg_count(function)
    Fun::F::ImplicitArgumentCounter.new(function).count
  end

  it "returns 1 for a function that only contains a reference to it" do
    foo = lambda{it + 1}

    expect(arg_count(foo)).to eq(1)
  end

  it "returns 3 for fuction that uses a, b, and c" do
    foo = lambda{a * b + c}

    expect(arg_count(foo)).to eq(3)
  end

  it "counts variables also in deeply nested expressions" do
    foo = lambda{ a.map{|i| i + b } + foo(c) }

    expect(arg_count(foo)).to eq(3)
  end

  it "returns 3 for a function that only uses c" do
    foo = lambda{ bar * c }

    expect(arg_count(foo)).to eq(3)
  end

  it "returns 5 for a function that uses it and e" do
    foo = lambda{ it + e }

    expect(arg_count(foo)).to eq(5)
  end

  it "returns -1 if one of the called methods is args" do
    foo = lambda{args.map{|i| i + 1}}

    expect(arg_count(foo)).to eq(-1)
  end

  it "does not count bound local variables" do
    a = 1
    foo = lambda{a + 1}

    expect(arg_count(foo)).to eq(0)
  end
end
