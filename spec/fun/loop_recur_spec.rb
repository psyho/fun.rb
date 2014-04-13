require 'spec_helper'

describe "tloop/recur" do
  it "regular recursion blows the stack" do
    factorial = fn do |n|
      return 1 if n <= 1
      n * factorial[n-1]
    end

    expect {
      factorial[10000]
    }.to raise_error(SystemStackError)
  end

  it "allows deep recursion without blowing the stack" do
    factorial = fn do |n|
      tloop do |k = n, result = 1|
        return result if k <= 1
        recur(k - 1, result * k)
      end
    end

    expect(factorial[10000]).to eq((1..10000).reduce(:*))
  end

  it "allows self-recursion" do
    factorial = fn do |n, result = 1|
      return result if n <= 1
      recur(n - 1, result * n)
    end

    expect(factorial[10000]).to eq((1..10000).reduce(:*))
  end

  it "blows up if you don't recur as the last instruction in the function" do
    factorial = fn do |n|
      return 1 if n <= 1
      recur(n-1) * n
    end

    expect{ factorial[10000] }.to raise_error(Fun::LoopRecur::InvalidRecur)
  end
end
