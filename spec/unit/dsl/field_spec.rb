# encoding: utf-8

require "shared/dsl"

describe Faceter::DSL::Field do

  describe ".new" do

    it_behaves_like "creating immutable branch" do
      let(:attributes) { [:foo] }
    end

  end # describe .new

  describe "#transproc" do

    # Subnodes to be applied sequentially to value under given key
    let(:node1) { Faceter::DSL::Rename.new(:foo, to: :bar) }
    let(:node2) { Faceter::DSL::Exclude.new(:qux)          }

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [:baz]                  }
      let(:block)      { proc { [node1, node2] } }

      let(:input)  { { baz: { foo: :FOO, qux: :QUX } } }
      let(:output) { { baz: { bar: :FOO } }            }
    end

  end # describe #transproc

end # describe Faceter::DSL::Field
