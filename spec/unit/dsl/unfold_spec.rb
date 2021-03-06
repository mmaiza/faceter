# encoding: utf-8

require "shared/dsl"

describe Faceter::DSL::Unfold do

  describe ".new" do

    it_behaves_like "creating immutable node" do
      let(:attributes) { [from: :foo] }
    end

  end # describe .new

  describe "#transproc" do

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [from: :foo] }

      let(:input)  { { foo: :FOO } }
      let(:output) { :FOO          }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [from: :foo] }

      let(:input)  { {}  }
      let(:output) { nil }
    end

  end # describe #transproc

end # describe Faceter::DSL::Unfold
