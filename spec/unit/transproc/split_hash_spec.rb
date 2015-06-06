describe Faceter::Transproc, "#split_hash" do

  subject { fn[input] }

  let(:fn)     { described_class[:split_hash, [:foo, :baz]]                 }
  let(:input)  { { foo: :FOO, bar: :BAR, baz: :BAZ, qux: :QUX }       }
  let(:output) { [{ foo: :FOO, baz: :BAZ }, { bar: :BAR, qux: :QUX }] }

  it { is_expected.to eql output }

end # describe Faceter::Transproc#split_hash
