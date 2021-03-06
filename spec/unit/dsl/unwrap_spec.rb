# encoding: utf-8

require "shared/dsl"

describe Faceter::DSL::Unwrap do

  describe ".new" do

    it_behaves_like "creating immutable node" do
      let(:attributes) { [from: :baz] }
    end

  end # describe .new

  describe "#transproc" do

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [:foo, :bar, from: :baz] }

      let(:input)  { { baz: { foo: :FOO, bar: :BAR, baz: :BAZ }, qux: :QUX } }
      let(:output) { { baz: { baz: :BAZ }, qux: :QUX, foo: :FOO, bar: :BAR } }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [from: :baz, only: [:foo, :bar]] }

      let(:input)  { { baz: { foo: :FOO, bar: :BAR, baz: :BAZ }, qux: :QUX } }
      let(:output) { { baz: { baz: :BAZ }, qux: :QUX, foo: :FOO, bar: :BAR } }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [from: :bar, only: [:foo, :bar]] }

      let(:input)  { { bar: { foo: :FOO, bar: :BAR, baz: :BAZ }, qux: :QUX } }
      let(:output) { { qux: :QUX, foo: :FOO, bar: :BAR }                     }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [from: :bar, only: [:foo, :bar]] }

      let(:input)  { { bar: { foo: :FOO, bar: { baz: :BAZ } }, qux: :QUX } }
      let(:output) { { qux: :QUX, foo: :FOO, bar: { baz: :BAZ } }          }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [from: :bar, only: :foo] }

      let(:input)  { { foo: { baz: :BAZ }, bar: { foo: { baz: :QUX } } } }
      let(:output) { { foo: { baz: :QUX } }                              }
    end

    it_behaves_like "mapping immutable input" do
      let(:attributes) { [from: :bar] }

      let(:input)  { { bar: { foo: :FOO, bar: :BAR, baz: :BAZ }, qux: :QUX } }
      let(:output) { { qux: :QUX, foo: :FOO, bar: :BAR, baz: :BAZ }          }
    end

  end # describe #transproc

end # describe Faceter::DSL::Unwrap
