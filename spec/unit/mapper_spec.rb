# encoding: utf-8

describe Faceter::Mapper do

  before do
    class Faceter::Test < Faceter::Mapper
      rename :foo, to: :bar
    end
  end

  let(:test) { Faceter::Test }

  subject(:mapper) { test.new { rename :foo, to: :bar } }

  describe ".builder" do

    subject { described_class.builder }

    it "is a builder with empty tree" do
      expect(subject).to be_kind_of Faceter::Builder
      expect(subject.tree.entries).to be_empty
    end

  end # describe .tree

  describe ".new" do

    it { is_expected.to be_frozen }

  end # describe .new

  describe "#call" do

    subject { mapper.call(foo: :FOO) }
    it { is_expected.to eql(bar: :FOO) }

  end # describe #transproc

  after { Faceter.send :remove_const, :Test }

end # describe Faceter::Mapper
