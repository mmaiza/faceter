# encoding: utf-8

require "shared/functions"

describe Faceter::Functions::Tuples, "#clean" do

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:clean] }

    let(:input)  { { foo: { foo: :FOO }, bar: {}, baz: {}, qux: :QUX } }
    let(:output) { { foo: { foo: :FOO }, bar: {}, baz: {}, qux: :QUX } }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:clean, []] }

    let(:input)  { { foo: { foo: :FOO }, bar: {}, baz: {}, qux: :QUX } }
    let(:output) { { foo: { foo: :FOO }, bar: {}, baz: {}, qux: :QUX } }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:clean, :foo] }

    let(:input)  { { foo: { foo: :FOO }, bar: {}, baz: {}, qux: :QUX } }
    let(:output) { { foo: { foo: :FOO }, bar: {}, baz: {}, qux: :QUX } }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:clean, :bar] }

    let(:input)  { { foo: { foo: :FOO }, bar: {}, baz: {}, qux: :QUX } }
    let(:output) { { foo: { foo: :FOO }, baz: {}, qux: :QUX }          }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:clean, [:foo, :bar]] }

    let(:input)  { { foo: { foo: :FOO }, bar: {}, baz: {}, qux: :QUX } }
    let(:output) { { foo: { foo: :FOO }, baz: {}, qux: :QUX }          }
  end

end # describe Faceter::Functions::Tuples#clean
