describe Faceter::Transproc, "#begird" do

  subject { fn[input] }

  context "not a hash" do

    let(:fn)     { described_class[:begird, :foo] }
    let(:input)  { :BAR          }
    let(:output) { { foo: :BAR } }

    it { is_expected.to eql output }

  end # context

  context "hash without keys" do

    let(:fn)     { described_class[:begird, :foo]          }
    let(:input)  { { bar: :BAR, baz: :BAZ }          }
    let(:output) { { foo: { bar: :BAR, baz: :BAZ } } }

    it { is_expected.to eql output }

  end # context

  context "hash with full set of keys" do

    let(:fn)     { described_class[:begird, :foo, [:bar, :baz]] }
    let(:input)  { { bar: :BAR, baz: :BAZ }               }
    let(:output) { { foo: { bar: :BAR, baz: :BAZ } }      }

    it { is_expected.to eql output }

  end # context

  context "hash with subset of keys" do

    let(:fn)     { described_class[:begird, :foo, [:bar]]  }
    let(:input)  { { bar: :BAR, baz: :BAZ }          }
    let(:output) { { foo: { bar: :BAR }, baz: :BAZ } }

    it { is_expected.to eql output }

  end # context

  context "hash with absent keys" do

    let(:fn)     { described_class[:begird, :foo, [:bar, :qux]]    }
    let(:input)  { { bar: :BAR, baz: :BAZ }          }
    let(:output) { { foo: { bar: :BAR }, baz: :BAZ } }

    it { is_expected.to eql output }

  end # context

  context "existing subhash" do

    let(:fn)     { described_class[:begird, :foo, [:bar]]          }
    let(:input)  { { bar: :BAR, foo: { baz: :BAZ } } }
    let(:output) { { foo: { bar: :BAR, baz: :BAZ } } }

    it { is_expected.to eql output }

  end # context

end # describe Faceter::Transproc#begird
