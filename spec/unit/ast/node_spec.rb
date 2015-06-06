# encoding: utf-8

describe Faceter::AST::Node do

  describe ".branch?" do

    subject { described_class.branch? }
    it { is_expected.to eql false }

  end # describe .branch?

end # describe Faceter::AST::Node
