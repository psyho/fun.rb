require 'spec_helper'

describe Fun::Getters do
  describe "dot" do
    class Person < Struct.new(:name)
    end

    it "calls the method given" do
      bob = Person.new("Bob")
      john = Person.new("John")

      name = Fun.dot(:name)

      expect(name[bob]).to eq("Bob")
      expect(name[john]).to eq("John")
    end

    it "is fully curriable" do
      bob = Person.new("Bob")
      dot = Fun.dot

      expect(dot[:name][bob]).to eq("Bob")
      expect(dot[:name, bob]).to eq("Bob")
    end
  end

  describe "key" do
    key = Fun.key
    name = key[:name]

    it "returns the map value under key" do
      expect(name[name: "Bob", id: 1]).to eq("Bob")
    end

    it "returns the map value under string key" do
      hash = {"foo" => 123}
      name = key["foo"]

      expect(name[hash]).to eq(123)
    end

    it "returns nil if the key is not present" do
      expect(name[{}]).to eq(nil)
    end

    it "returns nil when called with nil hash" do
      expect(name[nil]).to eq(nil)
    end

    it "allows swapping map and the symbol" do
      hash = {foo: 123}

      expect(key[:foo, hash]).to eq(123)
      expect(key[hash, :foo]).to eq(123)
    end

    it "allows swapping map and the string" do
      hash = {"foo" => 123}

      expect(key['foo', hash]).to eq(123)
      expect(key[hash, 'foo']).to eq(123)
    end

    it "is fully curriable" do
      hash = {foo: 123}

      expect(key[:foo][hash]).to eq(123)
      expect(key[:foo, hash]).to eq(123)
    end
  end

  describe "get" do
    get = Fun.get

    it "returns the value under symbol" do
      hash = {foo: 123, "bar" => 1}
      foo = get[:foo]

      expect(foo[hash]).to eq(123)
    end

    it "returns the value under string" do
      hash = {foo: 123, "bar" => 1}
      bar = get[:bar]

      expect(bar[hash]).to eq(1)
    end

    it "allows swapping the symbol and the hash" do
      hash = {foo: 123, "bar" => 1}

      expect(get[hash, :bar]).to eq(1)
      expect(get[:bar, hash]).to eq(1)
    end

    it "takes a string, as well as symbol as the key" do
      hash = {foo: 123, "bar" => 1}

      expect(get[hash, "foo"]).to eq(123)
      expect(get["foo", hash]).to eq(123)
    end

    it "is fully curriable" do
      hash = {foo: 123, "bar" => 1}

      expect(get[:foo][hash]).to eq(123)
      expect(get[:bar, hash]).to eq(1)
    end
  end

  describe "nth" do
    nth = Fun.nth

    it "returns the nth element of an array" do
      arr = [:a, :b, :c]
      first = nth[0]

      expect(first[arr]).to eq(:a)
    end

    it "allows swapping the array and the element" do
      arr = [:a, :b, :c]

      expect(nth[arr, 1]).to eq(:b)
      expect(nth[1, arr]).to eq(:b)
    end

    it "is fully curriable" do
      arr = [:a, :b, :c]

      expect(nth[arr][1]).to eq(:b)
      expect(nth[arr, 1]).to eq(:b)
    end
  end
end
