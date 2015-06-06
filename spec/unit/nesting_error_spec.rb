describe Faceter::NestingError do

  subject(:error) { described_class.new }

  it { is_expected.to be_kind_of RuntimeError }

  describe "#message" do

    subject(:message) { error.message }

    it { is_expected.to eq "useless nesting without transformations" }

  end # describe #message

end # describe Faceter::NestingError
