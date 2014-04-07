require 'spec_helper'


describe "tloop/recur" do
  it "regular recursion blows the stack" do
    factorial = tfn do |n|
      if n <= 1
        1
      else
        n * factorial[n-1]
      end
    end

    expect {
      factorial[10000]
    }.to raise_error(SystemStackError)
  end

  it "allows deep recursion without blowing the stack" do
    factorial = tfn do |n|
      tloop do |k = n, result = 1|
        if k <= 1
          result
        else
          recur(k - 1, result * k)
        end
      end
    end

    expect(factorial[10000]).to eq((1..10000).reduce(:*))
  end

  it "allows self-recursion" do
    factorial = tfn do |n, result = 1|
      if n <= 1
        result
      else
        recur(n - 1, result * n)
      end
    end

    expect(factorial[10000]).to eq((1..10000).reduce(:*))
  end
end
