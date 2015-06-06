describe Faceter::Transproc, "#drop_prefix" do

  subject { fn[input] }

  let(:fn) { described_class[:drop_prefix, "foo", "."] }

  context "to string without prefix" do

    let(:input)  { :bar  }
    let(:output) { "bar" }

    it { is_expected.to eql output }

  end # context

  context "to string with prefix" do

    let(:input)  { "foo.bar" }
    let(:output) { "bar"     }

    it { is_expected.to eql output }

  end # context

end # describe Faceter::Transproc#drop_prefix
