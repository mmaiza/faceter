describe Faceter::Transproc, "#keep_symbol" do

  subject { fn[input] }

  let(:fn) { described_class[:keep_symbol, function] }

  let(:function) { -> value { value.to_s.reverse } }

  context "to string" do

    let(:input)  { "bar" }
    let(:output) { "rab" }

    it { is_expected.to eql output }

  end # context

  context "to symbol" do

    let(:input)  { :bar }
    let(:output) { :rab }

    it { is_expected.to eql output }

  end # context

end # describe Faceter::Transproc#keep_symbol
