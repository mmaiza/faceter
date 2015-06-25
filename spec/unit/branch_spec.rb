# encoding: utf-8

describe Faceter::Branch do

  around do |example|
    Faceter::Node1 = Class.new(Faceter::Node)
    Faceter::Node2 = Class.new(Faceter::Node)
    Faceter::Node3 = Class.new(Faceter::Node)
    example.run
    %w(Node1 Node2 Node3).each { |name| Faceter.send :remove_const, name }
  end

  let(:node1) { instance_double Faceter::Node1 }
  let(:node2) { instance_double Faceter::Node2 }
  let(:node3) { instance_double Faceter::Node3 }

  subject(:branch) { described_class.new(:foo) { [node1, node2] } }

  describe ".branch?" do

    subject { described_class.branch? }
    it { is_expected.to eql true }

  end # describe .branch?

  describe ".new" do

    it { is_expected.to be_kind_of Enumerable }
    it { is_expected.to be_frozen             }

  end # describe .new

  describe "#rebuild" do

  end # describe #rebuild

  describe "#each" do

    let(:subnodes) { [node1, node2] }

    context "with a block" do

      subject { branch.each { |item| item } }

      it "looks over subnodes" do
        expect(subject).to eql subnodes
      end

    end # context

    context "without a block" do

      subject { branch.each }

      it "returns Enumerator for subnodes" do
        expect(subject).to be_kind_of Enumerator
        expect(subject.entries).to eql subnodes
      end

    end # context

  end # describe #each

  describe "#+" do

    subject { branch + node3 }

    it "returns the branch with updated subnodes and the same attributes" do
      expect(subject).to be_kind_of described_class
      expect(subject.attributes).to eql branch.attributes
      expect(subject.entries).to eql [node1, node2, node3]
    end

  end # describe #add

  describe "#finalize" do

    subject { branch.finalize }

    context "with subnodes" do

      let(:node1) { instance_double Faceter::Node1, finalize: node2 }
      let(:node2) { instance_double Faceter::Node2, finalize: node3 }

      it "returns branch with the same attributes and finalized subnodes" do
        expect(subject).to be_kind_of described_class
        expect(subject.attributes).to eql branch.attributes
        expect(subject.entries).to eql [node2, node3]
      end

    end # context

    context "without subnodes" do

      let(:branch)  { described_class.new }
      let(:mention) { branch.inspect      }

      it "fails" do
        expect { subject }.to raise_error do |error|
          expect(error).to be_kind_of Faceter::Error
          expect(error.message).to include mention
        end
      end

    end # context

  end # describe #finalize

  describe "#transproc" do

    let(:node1) { instance_double Faceter::Node1, transproc: fn1    }
    let(:node2) { instance_double Faceter::Node2, transproc: fn2    }
    let(:fn1)   { Faceter::Functions::Keys[:add_prefix, "bar", "_"] }
    let(:fn2)   { Faceter::Functions::Keys[:add_prefix, "foo", "_"] }
    let(:data)  { "baz"                                             }

    subject { branch.transproc[data] }
    it { is_expected.to eql "foo_bar_baz" }

  end # describe #transproc

  describe "#to_s" do

    subject { branch.to_s }

    context "of the root" do

      let(:branch) { described_class.new { [node1, node2] } }

      it { is_expected.to eql "Root() [#{node1.inspect}, #{node2.inspect}]" }

    end # context

    context "of the specific node" do

      let(:test)   { Faceter::Test = Class.new(described_class) }
      let(:branch) { test.new(:foo) { [node1, node2] } }

      it do
        is_expected.to eql "Test(:foo) [#{node1.inspect}, #{node2.inspect}]"
      end

      after { Faceter.send :remove_const, :Test }

    end # context

  end # describe #to_s

end # describe Branch
