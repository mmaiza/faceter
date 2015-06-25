# encoding: utf-8

require "shared/functions"

describe Faceter::Functions::Conditionals, "#apply_to_hash" do

  let(:block) { -> hash { hash.keys.map(&:to_s).zip(hash.values).to_h } }

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:apply_to_hash, false, block] }

    let(:input)  { :foo }
    let(:output) { :foo }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:apply_to_hash, false, block] }

    let(:input)  { { foo: :FOO, bar: [{ baz: :BAZ }] }         }
    let(:output) { { "foo" => :FOO, "bar" => [{ baz: :BAZ }] } }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:apply_to_hash, true, block] }

    let(:input)  { { foo: :FOO, bar: [{ baz: :BAZ }] }             }
    let(:output) { { "foo" => :FOO, "bar" => [{ "baz" => :BAZ }] } }
  end

end # describe Faceter::Functions::Conditionals#apply_to_hash
