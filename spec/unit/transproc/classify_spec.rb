describe Faceter::Transproc, "#classify" do

  subject { fn[input] }

  let(:fn)     { described_class[:classify]              }
  let(:input)  { [1, 1.0, 2, 2, 1.0, 1, 1]               }
  let(:output) { { 1 => [1.0], 2 => [2], 1.0 => [1, 1] } }

  it { is_expected.to eql output }

end # describe Faceter::Transproc#classify
