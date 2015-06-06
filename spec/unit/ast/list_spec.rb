# encoding: utf-8

describe Faceter::AST::List do

  let(:list) { described_class.new }

  describe "#==" do

    subject { list == other }

    context "another list" do

      let(:other) { described_class.new }
      it { is_expected.to eql true }

    end # context

    context "not a list" do

      let(:other) { Faceter::AST::Field.new :foo }
      it { is_expected.to eql false }

    end # context

  end # describe #==

end # describe Faceter::AST::List
