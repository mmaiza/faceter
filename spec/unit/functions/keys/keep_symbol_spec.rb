# encoding: utf-8

require "shared/functions"

describe Faceter::Functions::Keys, "#keep_symbol" do

  let(:function) { -> value { value.to_s.reverse } }

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:keep_symbol, function] }

    let(:input)  { "bar" }
    let(:output) { "rab" }
  end

  it_behaves_like "transforming immutable data" do
    let(:arguments) { [:keep_symbol, function] }

    let(:input)  { :bar }
    let(:output) { :rab }
  end

end # describe Faceter::Functions::Keys#keep_symbol
