# encoding: utf-8

describe Faceter::AST::Root do

  describe ".branch?" do

    subject { described_class.branch? }
    it { is_expected.to eql true }

  end # describe .branch?

end # describe Faceter::AST::Root
