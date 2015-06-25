# encoding: utf-8

require "shared/dsl"

describe Faceter::DSL::Rename do

  describe ".new" do

    it_behaves_like "creating immutable node" do
      let(:attributes) { [:foo, to: :bar] }
    end

  end # describe .new

  describe "#finalize" do

    it_behaves_like "accepting the node" do
      let(:attributes) { [:foo, to: "foo"] }
    end

    it_behaves_like "complaining about the useless node" do
      let(:attributes) { [:foo, to: :foo] }
    end

  end # describe #finalize

  describe "#transproc" do

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [:foo, to: "bar"] }

      let(:input)  { { foo: :FOO }     }
      let(:output) { { "bar" => :FOO } }
    end

  end # describe #transproc

end # describe Faceter::DSL::Rename
