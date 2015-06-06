describe Faceter::Transproc, "#clear_tuples" do

  subject { fn[input] }

  let(:fn)     { described_class[:clear_tuples, [:foo, :bar]]   }
  let(:input)  { { foo: {}, bar: { bar: :BAR }, baz: {} } }
  let(:output) { { bar: { bar: :BAR }, baz: {} }          }

  it { is_expected.to eql output }

end # describe Faceter::Transproc#clear_tuples
