require 'spec_helper'

describe Fun::F::ImplicitArgumentCounter do
  def arg_count(function)
    Fun::F::ImplicitArgumentCounter.new(function).count
  end

  it "returns 1 for a function that only contains a reference to it" do
    foo = proc{it + 1}

    expect(arg_count(foo)).to eq(1)
  end

  it "returns 3 for fuction that uses a, b, and c" do
    foo = proc{a * b + c}

    expect(arg_count(foo)).to eq(3)
  end

  it "counts variables also in deeply nested expressions" do
    foo = proc{ a.map{|i| i + b } + foo(c) }

    expect(arg_count(foo)).to eq(3)
  end

  it "returns 3 for a function that only uses c" do
    foo = proc{ bar * c }

    expect(arg_count(foo)).to eq(3)
  end

  it "returns 5 for a function that uses it and e" do
    foo = proc{ it + e }

    expect(arg_count(foo)).to eq(5)
  end

  it "does not count bound local variables" do
    a = 1
    foo = proc{a + 1}

    expect(arg_count(foo)).to eq(0)
  end
end
