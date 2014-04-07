require 'spec_helper'

describe "fn{}" do
  it "creates an auto-curried proc" do
    sum = fn{|a,b| a + b}
    inc = sum[1]

    expect(inc[5]).to eq(6)
  end

  it "adds loop/recur capabilities to the returned proc" do
    last = fn do |arr|
      if arr.size <= 1
        arr.first
      else
        recur(arr[1..-1])
      end
    end

    expect(last[[1,2,3]]).to eq(3)
  end
end
