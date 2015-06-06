describe Faceter::Transproc, "#ungird" do

  subject { fn[input] }

  context "without keys" do

    let(:fn)     { described_class[:ungird, :foo]               }
    let(:input)  { { foo: { bar: :BAR, baz: :BAZ }, qux: :QUX } }
    let(:output) { { bar: :BAR, baz: :BAZ }                     }

    it { is_expected.to eql output }

  end # context

  context "with full set of keys" do

    let(:fn)     { described_class[:ungird, :foo, [:bar, :baz]] }
    let(:input)  { { foo: { bar: :BAR, baz: :BAZ }, qux: :QUX } }
    let(:output) { { bar: :BAR, baz: :BAZ, qux: :QUX }          }

    it { is_expected.to eql output }

  end # context

  context "with subset of keys" do

    let(:fn)     { described_class[:ungird, :foo, [:baz]]       }
    let(:input)  { { foo: { bar: :BAR, baz: :BAZ }, qux: :QUX } }
    let(:output) { { foo: { bar: :BAR }, baz: :BAZ, qux: :QUX } }

    it { is_expected.to eql output }

  end # context

  context "with absent keys" do

    let(:fn)     { described_class[:ungird, :foo, [:baz, :qux]] }
    let(:input)  { { foo: { bar: :BAR, baz: :BAZ }, qux: :QUX } }
    let(:output) { { foo: { bar: :BAR }, baz: :BAZ, qux: :QUX } }

    it { is_expected.to eql output }

  end # context

end # describe Faceter::Transproc#ungird
