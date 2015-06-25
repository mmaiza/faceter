# encoding: utf-8

describe Faceter::DSL do

  before do
    allow(described_class::COMMANDS)
      .to receive(:[]) { |name| :FOO if name == :foo }
  end

  describe ".defines?" do

    context "registered name" do

      subject { described_class.defines? :foo }
      it { is_expected.to eql true }

    end # context

    context "unregistered name" do

      subject { described_class.defines? :bar }
      it { is_expected.to eql false }

    end # context

  end # describe .defines?

end # describe Faceter::DSL
