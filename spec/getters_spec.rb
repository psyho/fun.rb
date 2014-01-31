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
end
