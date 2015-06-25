# encoding: utf-8

describe Faceter::Builder do

  before { Faceter::Test = Class.new(Faceter::Branch) }
  after  { Faceter.send :remove_const, :Test          }

  let(:tree) { instance_double Faceter::Test }

  subject(:builder) { described_class.new tree }

  describe ".new" do

    context "without a tree" do

      subject { described_class.new }

      it "sets the emtpy tree" do
        expect(subject.tree).to be_instance_of Faceter::Branch
        expect(subject.tree.entries).to be_empty
      end

    end # context

    context "with a tree" do

      subject { described_class.new tree }

      it "uses the tree" do
        expect(subject.tree).to eql tree
      end

    end # context

    context "with a block" do

      subject { described_class.new(tree) { @tree = :foo } }

      it "evaluates the block in the scope of new builder" do
        expect(subject.tree).to eql :foo
      end

    end # context

    it { is_expected.to be_frozen }

  end # describe .new

  describe "#tree" do

    subject { builder.tree }

    it { is_expected.to eql tree }

  end # describe #tree

  describe "#finalize" do

    let(:valid_tree) { double }
    before { allow(tree).to receive(:finalize) { valid_tree } }

    subject { builder.finalize }
    it { is_expected.to eql valid_tree }

  end # describe #finalize

  describe "#respond_to_missing?" do

    before { allow(Faceter::DSL).to receive(:defines?) { |name| name == :foo } }

    context "registered command" do

      subject { builder.respond_to? :foo }
      it { is_expected.to eql true }

    end # context

    context "unregistered command" do

      subject { builder.respond_to? :bar }
      it { is_expected.to eql false }

    end # context

  end # describe #respond_to_missing?

end # describe Faceter::Builder
