# encoding: utf-8

describe Faceter::Node do

  before { Faceter::TestNode = Class.new(described_class) }
  after  { Faceter.send :remove_const, :TestNode          }

  let(:attributes) { [:foo, :bar]          }
  let(:test)       { Faceter::TestNode     }
  subject(:node)   { test.new(*attributes) }

  describe ".branch?" do

    subject { test.branch? }
    it { is_expected.to eql false }

  end # describe .branch?

  describe ".new" do

    it { is_expected.to be_frozen             }

  end # describe .new

  describe "#attributes" do

    subject { node.attributes }

    it { is_expected.to eql attributes }

  end # describe #attributes

  describe "#to_s" do

    subject { node.to_s }
    it { is_expected.to eql "TestNode(:foo, :bar)" }

  end # describe #to_s

  describe "#inspect" do

    subject { node.inspect }
    it { is_expected.to eql "<TestNode(:foo, :bar)>" }

  end # describe #inspect

  describe "#transproc" do

    subject { node.transproc }
    it { is_expected.to be_nil }

  end # describe #transproc

  describe "#finalize" do

    subject { node.finalize }
    it { is_expected.to eql node }

  end # describe #finalize

end # describe Faceter::Node
