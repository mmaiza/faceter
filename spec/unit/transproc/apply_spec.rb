describe Faceter::Transproc, "#apply" do

  subject { fn[input] }

  let(:block) { -> *values { values.join(", ") } }

  context "to the whole object" do

    let(:fn)     { described_class[:apply, block] }
    let(:input)  { :bar  }
    let(:output) { "bar" }

    it { is_expected.to eql output }

  end # context

  context "to hash" do

    let(:fn)     { described_class[:apply, block, [:foo, :bar]] }
    let(:input)  { { foo: :FOO, bar: :BAR, baz: :BAZ }    }
    let(:output) { "FOO, BAR"                             }

    it { is_expected.to eql output }

  end # context

end # describe Faceter::Transproc#apply
