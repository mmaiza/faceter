describe Faceter::Transproc, "#camelize" do

  subject { fn[input] }

  let(:fn)     { described_class[:camelize] }
  let(:input)  { "some_item"                }
  let(:output) { "SomeItem"                 }

  it { is_expected.to eql output }

end # describe Faceter::Transproc#camelize
