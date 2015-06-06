describe Faceter::Transproc, "#merge" do

  subject { fn[input] }

  let(:input) { { foo: :FOO, bar: :BAR }            }
  let(:proc)  { -> value { :BAZ if value == input } }

  context "without a key" do

    let(:fn)     { described_class[:merge, proc] }
    let(:output) { :BAZ                    }

    it { is_expected.to eql output }

  end # context

  context "with an existing key" do

    let(:fn)     { described_class[:merge, proc, :foo] }
    let(:output) { { foo: :BAZ, bar: :BAR }      }

    it { is_expected.to eql output }

  end # context

  context "with a new key" do

    let(:fn)     { described_class[:merge, proc, :baz]       }
    let(:output) { { foo: :FOO, bar: :BAR, baz: :BAZ } }

    it { is_expected.to eql output }

  end # context

end # describe Faceter::Transproc#merge
