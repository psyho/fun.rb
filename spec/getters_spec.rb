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
end
