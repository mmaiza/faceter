describe Faceter::Transproc, "#maybe" do

  subject { fn[input] }

  let(:fn)      { described_class[:maybe, ::Hash, default] }
  let(:default) { { bar: :BAR }                      }

  context "valid type" do

    let(:input)  { { foo: :FOO } }

    it { is_expected.to eql input }

  end # context

  context "with full set of keys" do

    let(:input)  { :FOO }

    it { is_expected.to eql default }

  end # context

end # describe Faceter::Transproc#maybe
