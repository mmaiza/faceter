describe Faceter::Error do

  subject(:error) { described_class.new double(inspect: "<foo>") }

  it { is_expected.to be_kind_of RuntimeError }

  describe "#message" do

    subject { error.message }
    it { is_expected.to eql "The node <foo> is worthless" }

  end # describe #message

end # describe Faceter::Error
