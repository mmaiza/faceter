# encoding: utf-8

require "shared/functions"

describe Faceter::Functions::Conditionals, "#execute" do

  let(:function) { -> v { v.to_s } }

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:execute, function] }

    let(:input)  { :bar  }
    let(:output) { "bar" }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:execute, function, :foo] }

    let(:input)  { { foo: :FOO, bar: :BAR } }
    let(:output) { "FOO"                      }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:execute, function, [:foo, :bar]] }

    let(:input)  { { foo: "FOO", bar: "BAR" } }
    let(:output) { "[\"FOO\", \"BAR\"]"       }
  end

end # describe Faceter::Functions::Conditionals#execute
