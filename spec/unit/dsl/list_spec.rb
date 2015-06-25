# encoding: utf-8

require "shared/dsl"

describe Faceter::DSL::List do

  describe ".new" do

    it_behaves_like "creating immutable branch" do
      let(:attributes) { [] }
    end

  end # describe .new

  describe "#transproc" do

    # Subnodes to be applied sequentially to every item of the array
    let(:node1) { Faceter::DSL::Rename.new(:foo, to: :bar) }
    let(:node2) { Faceter::DSL::Exclude.new(:qux)          }

    it_behaves_like "mapping immutable input" do
      let(:attributes) { []                      }
      let(:block)      { proc { [node1, node2] } }

      let(:input)  { [{ foo: :FOO, qux: :BAZ }, { foo: :BAR, qux: :QUX }] }
      let(:output) { [{ bar: :FOO }, { bar: :BAR }]                       }
    end

  end # describe #transproc

end # describe Faceter::DSL::List
