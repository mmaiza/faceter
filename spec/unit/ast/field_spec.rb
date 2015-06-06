# encoding: utf-8

describe Faceter::AST::Field do

  describe "#==" do

    let(:field) { described_class.new :foo }
    subject { field == other }

    context "another field with the same name" do

      let(:other) { described_class.new :foo }
      it { is_expected.to eql true }

    end # context

    context "another field with another name" do

      let(:other) { described_class.new :bar }
      it { is_expected.to eql false }

    end # context

    context "not a field" do

      let(:other) { Faceter::AST::List.new }
      it { is_expected.to eql false }

    end # context

  end # describe #==

end # describe Faceter::AST::Field
