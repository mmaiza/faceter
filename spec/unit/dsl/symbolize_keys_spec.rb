# encoding: utf-8

require "shared/dsl"

describe Faceter::DSL::SymbolizeKeys do

  describe ".new" do

    it_behaves_like "creating immutable node" do
      let(:attributes) { [] }
    end

  end # describe .new

  describe "#transproc" do

    it_behaves_like "transforming immutable data" do
      let(:attributes) { [] }

      let(:input)  { { "foo" => [{ "bar" => :BAZ }] } }
      let(:output) { { foo: [{ bar: :BAZ }] }         }
    end

    it_behaves_like "transforming immutable data" do
      let(:attributes) { [nested: false] }

      let(:input)  { { "foo" => [{ "bar" => :BAZ }] } }
      let(:output) { { foo: [{ "bar" => :BAZ }] }     }
    end

  end # describe #transproc

end # describe Faceter::DSL::SymbolizeKeys
