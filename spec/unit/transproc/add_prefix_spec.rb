describe Faceter::Transproc, "#add_prefix" do

  subject { fn[input] }

  let(:fn)     { described_class[:add_prefix, "foo", "."] }
  let(:input)  { "bar"     }
  let(:output) { "foo.bar" }

  it { is_expected.to eql output }

end # describe Faceter::Transproc#add_prefix
