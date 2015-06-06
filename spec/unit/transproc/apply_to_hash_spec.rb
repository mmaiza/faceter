describe Faceter::Transproc, "#apply_to_hash" do

  subject { fn[input] }

  let(:block) { -> hash { hash.keys.map(&:to_s).zip(hash.values).to_h } }

  context "to non-hash" do

    let(:fn)     { described_class[:apply_to_hash, false, block] }
    let(:input)  { :foo }
    let(:output) { :foo }

    it { is_expected.to eql output }

  end # context

  context "to nested hash non-recursively" do

    let(:fn)     { described_class[:apply_to_hash, false, block]     }
    let(:input)  { { foo: :FOO, bar: [{ baz: :BAZ }] }         }
    let(:output) { { "foo" => :FOO, "bar" => [{ baz: :BAZ }] } }

    it { is_expected.to eql output }

  end # context

  context "to nested hash recursively" do

    let(:fn)     { described_class[:apply_to_hash, true, block]          }
    let(:input)  { { foo: :FOO, bar: [{ baz: :BAZ }] }             }
    let(:output) { { "foo" => :FOO, "bar" => [{ "baz" => :BAZ }] } }

    it { is_expected.to eql output }

  end # context

end # describe Faceter::Transproc#apply_to_hash
