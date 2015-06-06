describe Faceter::Transproc, "#constantize" do

  subject { fn[input] }

  context "with a namespace" do

    let(:fn)     { described_class[:constantize, Faceter] }
    let(:input)  { "Transproc"                            }
    let(:output) { Faceter::Transproc                     }

    it { is_expected.to eql output }

  end # context

  context "without a namespace" do

    let(:fn)     { described_class[:constantize] }
    let(:input)  { :String                       }
    let(:output) { String                        }

    it { is_expected.to eql output }

  end # context

end # describe Faceter::Transproc#constantize
