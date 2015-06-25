# encoding: utf-8

require "shared/dsl"

describe Faceter::DSL::Exclude do

  describe ".new" do

    it_behaves_like "creating immutable node" do
      let(:attributes) { [:foo] }
    end

  end # describe .new

  describe "#finalize" do

    it_behaves_like "accepting the node" do
      let(:attributes) { [:foo] }
    end

    it_behaves_like "accepting the node" do
      let(:attributes) { [except: :foo] }
    end

    it_behaves_like "complaining about the useless node" do
      let(:attributes) { [] }
    end

  end # describe #finalize

  describe "#transproc" do

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [:foo, :bar] }

      let(:input)  { { foo: :FOO, bar: :BAR, baz: :BAZ } }
      let(:output) { { baz: :BAZ }                       }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [[:foo, :bar]] }

      let(:input)  { { foo: :FOO, bar: :BAR, baz: :BAZ } }
      let(:output) { { baz: :BAZ }                       }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [only: [:foo, :bar]] }

      let(:input)  { { foo: :FOO, bar: :BAR, baz: :BAZ } }
      let(:output) { { baz: :BAZ }                       }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [except: :foo] }

      let(:input)  { { foo: :FOO, bar: :BAR, baz: :BAZ } }
      let(:output) { { foo: :FOO }                       }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [except: [:foo, :bar]] }

      let(:input)  { { foo: :FOO, bar: :BAR, baz: :BAZ } }
      let(:output) { { foo: :FOO, bar: :BAR }            }
    end

  end # describe #transproc

end # describe Faceter::DSL::Exclude
